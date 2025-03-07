Return-Path: <linux-pm+bounces-23641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23753A56D1A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B8E3B925A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFB221DB6;
	Fri,  7 Mar 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp5q/mAj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A34221DA5;
	Fri,  7 Mar 2025 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363468; cv=none; b=jHOSTRNwhX8ALpifge7dd1UCLE2orOflh5MVJHSqj6Kdq+37lIBGF/ayVyXtbV++Loc2dWS/q7gTO4PbvQkuSS590rbzPxMlW1ZNlQ5bhPUGhMNragGuWsJq7gx6NptLxFwTlMCImunVgDpZagc24GC9ZD+dWvZePRcoC3v6q9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363468; c=relaxed/simple;
	bh=zQ5/51OJ6A7GH/km/DNm0NrLqE9BBXAG+s8BrdcniLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC9wcsfAE6dkPv5K1JQUmI4b20R3OFGaXto+qusJRtkAUJd7B6WCSkRSMLoonLuDPZeYLE4juOaeguEbKlimVQNO9LjKmRMsjv5/YqRV6kLx8TcS7TmcpZ9jY/evaRX4kyxIFVnif1GvrNxDTW51jCyQKT9OHHMclS29XRN95gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp5q/mAj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso11917165e9.0;
        Fri, 07 Mar 2025 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741363465; x=1741968265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwjL2JeCD7492pD+v5K74R2jLpOlCz510bxKlVeMnHc=;
        b=Sp5q/mAj0Beb2g/kKB5ZQ9fZxSOx+qamj0JJ6STfywu7FUQQz5hyvLshSl9NHLAh+e
         EThXjGGoI/HO9trZBy9EfHDt2jemBSqW1DfTLfKhxkBYA+M8cpbm/vorSk2UKOW6Ah+7
         1JA5mw+3e7sx+OMnR47ENrbae1LiLN/8tayfjtZajy2bWpCS7QIywLWKznyaSQ5tFfTD
         Q9FmBARQP/3SUiyz5lWZ9t7U9C/rB/f9W/zCvrezHTzWgGF1htJymJKBfq9PR4ISMNAo
         2g9dSKGG3gCPN539iyPEKOTEr61o7Nn1/MFaetrnyEZVnV5fb2prbxEhdX00czAXiI/l
         1khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363465; x=1741968265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwjL2JeCD7492pD+v5K74R2jLpOlCz510bxKlVeMnHc=;
        b=H3mk2JiPZM5EClmruLLWgkhOBjypeWYN0ZSYCjm2+O+i9HBzV4HS38yKLCLw8g0fIi
         0xrPeHJGRcvGe1muImmSF9tZJWiRwPob756qmcg/Gk4Rze2SxfJe4IENpX37FEofrDrT
         cYfD37aPL/RErD9T9wgdj9sfTExeNya96Ul+eckOjGdNTKr2N4RakTMHiP30ZrCc7BRI
         UznQ08pEK1itx33Dk4iiML4czTB8gaGpGsqm7igepZx1tuj+0Q34luL5PjllLhYA2cN8
         zWJkpgD1E6xMjPT7/9ESUdDaVqQoYlw7iQyqskAK16A9IZ7uDHNceZkyKty+CxRysB1U
         bTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJPCTSB8l5b6CnQTuDstGfWdagqgwig+0XS194+aN7n4a9FarJf2as6N9mumfTMu7EWDdoWfnNNr4q12w=@vger.kernel.org, AJvYcCVykE+hdbqF9edJgPZdRVO/aJaQe9nNrjHrJTkJZTQB/VBIGvNw6+j7pl0eMEIZhpfEhdhYp6XN2mBuLY0=@vger.kernel.org, AJvYcCXPmWC9AHJ0BIGL9UQnOorv8sWZi5636XlvKVdRDsN2j5SWPV0A2XUODVu09vxF/bcl/00hw/3mFPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNxuWd5WNJHHnJ533h3xL/SS2O3frxvX+82aqloeihHoSe6d7
	T5f/Pfon7PP1DKVzYKRBaadK8jd059DwIU4xvKsMzhFBx2NahfdE
X-Gm-Gg: ASbGnct3SzRX7Bp9O531tyPFwF5KpdggA6kS8bOsNTOq6ijf1sxJpfJCU0THRgUMAxo
	7m8uad2NMpcRjpreJQQ9/bSc5svXvQy76yi3ZsURq3JbOpWoEJOk2XYN53LtBI/enLzrGLAaUUt
	GRKchusykmgdoaAYyNRKCaFpOR8Pi8HUK33bQJ8schSR6ZNu5ArVAPTlbhzFz06HzR5WNjA0yox
	0QHe6gwMIgLEARxKZ8USkeQW3NIYSGvpbwIPMVEkxr1lGg4z14WIyyinCXh6DIeRl1CvFxemTAo
	mfP/WWClKkPauljgEFQnvQTN7CeSqIT8j56G0YVTQTZ02s7F9gXyp5rwIxLfr+YF1zzBwMO9iho
	OiaX3++39JKf/D+4ArQid1vTAkCxN8GI=
X-Google-Smtp-Source: AGHT+IGrAge31wWWWkJAL7QmrD3Y+M3QdNovaR6s8dn2J2Biu6rh9+8Zpq+lkjc7JUZ2mDgObHmWgw==
X-Received: by 2002:a05:600c:190f:b0:439:8346:505f with SMTP id 5b1f17b1804b1-43c5a631638mr24627945e9.20.1741363464415;
        Fri, 07 Mar 2025 08:04:24 -0800 (PST)
Received: from orome (p200300e41f3a9f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3a:9f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93c9b6sm55198925e9.29.2025.03.07.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:04:23 -0800 (PST)
Date: Fri, 7 Mar 2025 17:04:21 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
	Aaron Kling <luceoscutum@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
Message-ID: <cebhjkffkcksy4xx42yyfdpkyd22rmqbwmtcqoqn2grt7jy7iy@plqfstv3ng62>
References: <20250216160806.391566-1-webgeek1234@gmail.com>
 <20250303100306.rwaosbumr7omcqce@vireshk-i7>
 <fndrufuwpt4nptgs7hlucio6j7ia5sc4yeyasrherdv4dxs7s5@p4y6wsa7mxin>
 <c4ef9787-aaa6-463b-8c7d-6772fc208a48@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nbz2j76m3ebgwwor"
Content-Disposition: inline
In-Reply-To: <c4ef9787-aaa6-463b-8c7d-6772fc208a48@nvidia.com>


--nbz2j76m3ebgwwor
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
MIME-Version: 1.0

On Fri, Mar 07, 2025 at 08:45:29PM +0530, Sumit Gupta wrote:
>=20
>=20
> On 03/03/25 21:18, Thierry Reding wrote:
> > On Mon, Mar 03, 2025 at 03:33:06PM +0530, Viresh Kumar wrote:
> > > On 16-02-25, 10:08, Aaron Kling wrote:
> > > > This functionally brings tegra186 in line with tegra210 and tegra19=
4,
> > > > sharing a cpufreq policy between all cores in a cluster.
> > > >=20
> > > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > ---
> > > >   drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
> > > >   1 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/t=
egra186-cpufreq.c
> > > > index c7761eb99f3cc..c832a1270e688 100644
> > > > --- a/drivers/cpufreq/tegra186-cpufreq.c
> > > > +++ b/drivers/cpufreq/tegra186-cpufreq.c
> > > > @@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq=
_policy *policy)
> > > >   {
> > > >   	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> > > >   	unsigned int cluster =3D data->cpus[policy->cpu].bpmp_cluster_id;
> > > > +	u32 cpu;
> > > >   	policy->freq_table =3D data->clusters[cluster].table;
> > > >   	policy->cpuinfo.transition_latency =3D 300 * 1000;
> > > >   	policy->driver_data =3D NULL;
> > > > +	/* set same policy for all cpus in a cluster */
> > > > +	for (cpu =3D 0; cpu < (sizeof(tegra186_cpus)/sizeof(struct tegra1=
86_cpufreq_cpu)); cpu++) {
> > > > +		if (data->cpus[cpu].bpmp_cluster_id =3D=3D cluster)
> > > > +			cpumask_set_cpu(cpu, policy->cpus);
> > > > +	}
> > > > +
> > > >   	return 0;
> > > >   }
> > >=20
> > > Thierry / Jonathan,
> > >=20
> > > Any inputs on this ?
> >=20
> > Sumit,
> >=20
> > does this look reasonable?
> >=20
> > Thanks,
> > Thierry
>=20
> Looks good to me.
>=20
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

Thanks, in that case:

Acked-by: Thierry Reding <treding@nvidia.com>

--nbz2j76m3ebgwwor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfLGQUACgkQ3SOs138+
s6G3FQ/+PNLPhpaW15ilfxHRm6P2Ao8iip+lddH9yz+xhqgpD5yC8RGkVHU9P2Eo
iXH8aTAOgSSrHIPr1r11zx1DrCWI+BoXZWgkjBilVABL+c0hCPGQTP3/5TREsh6v
t0fQP189FamSz+YsMMnswWnYcAMYc+spX7nEmcgDxsM7vER1pu41wNBzWbEq+vGq
oCWIxtHAy7I/hbKNv3R7OqdlS+YLeGtZ4PKN/LhKyZgXAIhvTgGE+87aGsEg7HmL
9h1AzLAQPJbJSMoSXhxkfydAVLNyT0pp2pPT06+Ry8j8Ps/cVaOLFBUuh2WwHolN
lr5ORLjW1+ljmhwXHX7GIBD0vmVZcMfOf1ztIx3b5rxpAfcuGTLK3i8lalPg9EPn
FADy1Nr+2ZbYn8RJcjGp0xhpj6CCJPTjF/98RE9yrvN0v/Vp9UcvNP+QFbWSRcEF
zgQUsCmwLaQb5KBozv05rPngZxBjLltHxeFmx0Fip8xPY3oGk4jOX9Kn/gFGaZNk
dOpzNI9NDpFGpPtpSmnkOdvplyREhggcBAc59tvwNa/JM4NMHzdHfima1Gd0TP1W
b/kDgWFY242d/WfhwcSu5q0WhZkTadxoPmyMyQUekFNinTiEqpjlvj4mw1Olj4Ja
eDjDtyY8+Coc1e6JYThbUkXwQ3Ieu6UyX3GV5GpRVy2P+EXuzfk=
=5KPW
-----END PGP SIGNATURE-----

--nbz2j76m3ebgwwor--

