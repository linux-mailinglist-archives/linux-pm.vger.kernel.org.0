Return-Path: <linux-pm+bounces-40497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EFD05E96
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 20:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5EF3036CBB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F232B9AA;
	Thu,  8 Jan 2026 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="isjtNIRa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02678225A35
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767901915; cv=none; b=j2ZeTfx4pafSnqIGrwNxTjuPF7f566ZYosFWoST9QCzRxOt7Y70Jq1N8c39KKGYZEyu3weQhb9sgCjg3zchIIJtalbmLWuqGu9xm7lWlAv7yx8RivKRBuSH3dKxx+nLKd+3E8XLk4CuMPF2kCBnmrBEhrCyML9rkr1xOC2DyNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767901915; c=relaxed/simple;
	bh=02JsuwhWOjcj3EkU/m/bMwt0dkHrFQ69ZpfsGOyMPP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ExrTLBSsWkUHzJtHebBm8dFhO7VODpoane4DZxzUqcnk/pHXEvpsDOnLdXY1rdZyPyLMGU/IF11OM6dwjEg+Y62qB9Fq6hL4bEEn25C9IsirHGKpkKybCmsKOIJm/CmDRfeOJ5i5hcCgOaSENiSaC4YhmN3MVwl9xc9K+r0fzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=isjtNIRa; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8bb6a27d390so232204485a.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 11:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767901912; x=1768506712; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3t5MxAZO6uHQlXqGxbxcJlRM3XpAxH2j68+Yng+n1tE=;
        b=isjtNIRaNrv6obFJKOV8bAi2gdJM+y5iGvVZK2zqWIpuaJOK+lrYu8LQBlCNRd7Wml
         yCPJBS6YMp6deGtI0vxgq5rttSEeum7tuEMTyKnlCMeGGBwrNdrQIi4xUNpPkgM+Z8w1
         3IXaxU0HI1nez/BSbZ0qXwgv2DBINOztZ/40hSayASL1/HDb+/v7h+M6gwontwlKuevw
         36+ljNBIhFLdli+lUk8trtJkPf1XdYVxHoYTiRdNl/axysgaQ4z3Y1VstVpk0Yk9aJey
         LJ6PBGyNDbHX0Q1a7XCIoYIYGPwEwHkoJGKiqI6bT9h7JpMRo7aAgMYV1C4JRvNFIIIt
         7BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767901912; x=1768506712;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t5MxAZO6uHQlXqGxbxcJlRM3XpAxH2j68+Yng+n1tE=;
        b=HwCFXqQ2XnCF9neJP/LctmPRYDwX/kaI1ww1ah3bw7lbYCvI6O5GEu3fKyNKRam2jw
         kmqbr1Ln+Ecohres3rHFNcxrNMOjmh6oJ6WrdQkV6W1E7VWy5F8/7+loWU3fLE5XyvP6
         uBmfE5O5/J8hlI4KLAzw7l8D/b8gjos4dNvXU4v1dwYtHpcbkyBFWJ/iH7zAh+ulFvDV
         BqGaPuECZl3p7LHZEaesMOrBSCw1lLUoIjIcOvx3V3WMu/P1N/Egvpr7ZqknwMBISTLK
         bbV1a2RGkBKElXGlbWGW+QIk+AVCRxOUaerj9smnuDJ2zJLSrOs++K2gOHSC9XnUHyhp
         fRPw==
X-Forwarded-Encrypted: i=1; AJvYcCXUFu+wy3pHOIdTEKyovVo99ShtvmuBIssL4iaJDRRR54D49HPVkGg1HykXrKj+NYIk5bwEG+gLmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgW4Gop05PAil/YkXQl7h16wBz04s01qB/T1w7+KpNe+idwHW
	wb+GHXsTKBLMnBrbugbF8zpig9mRxtk1G7mQSKrfhWv4B/RlkrqWDf09ZvFG66veSkM=
X-Gm-Gg: AY/fxX6X6dr5ND6WlK0YZ+BO/iDMYTtM/Rkdu4Ywzi6nI9jgnvxsxxI2e4N70k5hM1E
	fPrEDgnAodrE+k9JCnJHs+Ro3MLGEcsk+CkPlw+b3D+JpxzBHX9Q2pPCf5+6lQZPWBDxZjCt2GZ
	KuBn6v+VRgltjOEFTRtw1wxOta2E4f2jmqYIEL4mFVxe5Ziej7TQFG7H0TaBPFvnTxfZMEGwq69
	wkTX99dYDUXSindpfDKXAuKYq7gakQImYvgKyQV/cZBQ7wb755czWOvGqd4+cmRQ+Xcg6gtX6wF
	+P9AINkWYkKxWdZBGuvhlK12tnHC02tSRdGyC+vk4u2tT+g84wesW2zH0+c3W62K4LzOKSCCmpb
	kqW6jDfvbD6N2f1IJRujcweruYdYltyIXk1LB3jLfXGlisTSXCiAQ8KG8WpOf9VjiQMvLrnWn5p
	1ZiobjOV1bOWVXDVt7S6kI16/LiY6mm5g=
X-Google-Smtp-Source: AGHT+IF07vV+0WA/n4b9oP2PTX45WFaUh5y+p0py1YN4/ZlnP6MfTnWeIOiCqeBE4tQFLsfHKxwQ0g==
X-Received: by 2002:a05:622a:11d3:b0:4f1:cd0c:80f6 with SMTP id d75a77b69052e-4ffb4a44431mr96306501cf.49.1767901911767;
        Thu, 08 Jan 2026 11:51:51 -0800 (PST)
Received: from [192.168.42.140] (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e4262sm58884036d6.20.2026.01.08.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:51:50 -0800 (PST)
Message-ID: <aa5536613a517caf5e954e94435f1a2229bad877.camel@ndufresne.ca>
Subject: Re: [RESEND][PATCH v1] media: mediatek: vcodec: Discard
 pm_runtime_put() return value
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>, 	linux-media@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>,  Brian Norris <briannorris@chromium.org>, Tiffany
 Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen	
 <andrew-ct.chen@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Date: Thu, 08 Jan 2026 14:51:47 -0500
In-Reply-To: <3396476.aeNJFYEL58@rafael.j.wysocki>
References: <3396476.aeNJFYEL58@rafael.j.wysocki>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-a3j3e/TWQhiEXlEjiWOs"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-a3j3e/TWQhiEXlEjiWOs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 08 janvier 2026 =C3=A0 16:23 +0100, Rafael J. Wysocki a =C3=A9crit=
=C2=A0:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Printing error messages on pm_runtime_put() returning negative values
> is not particularly useful.
>=20
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.
>=20
> Accordingly, update mtk_vcodec_enc_pw_off() and mtk_vcodec_dec_pw_off()
> to simply discard the return value of pm_runtime_put().
>=20
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>=20
> This is requisite for converting pm_runtime_put() into a void function.
>=20
> If you decide to pick it up, please let me know.
>=20
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
>=20
> Originally posted here:
>=20
> https://lore.kernel.org/linux-pm/3690736.iIbC2pHGDl@rafael.j.wysocki/
>=20
> ---
> =C2=A0drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c =
|=C2=A0=C2=A0=C2=A0 6 +--
> ---
> =C2=A0drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c =
|=C2=A0=C2=A0=C2=A0 6 +--
> ---
> =C2=A02 files changed, 2 insertions(+), 10 deletions(-)
>=20
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
> @@ -67,11 +67,7 @@ static int mtk_vcodec_dec_pw_on(struct m
> =C2=A0
> =C2=A0static void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
> =C2=A0{
> -	int ret;
> -
> -	ret =3D pm_runtime_put(pm->dev);
> -	if (ret && ret !=3D -EAGAIN)
> -		dev_err(pm->dev, "pm_runtime_put fail %d", ret);
> +	pm_runtime_put(pm->dev);
> =C2=A0}
> =C2=A0
> =C2=A0static void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
> @@ -71,11 +71,7 @@ int mtk_vcodec_enc_pw_on(struct mtk_vcod
> =C2=A0
> =C2=A0void mtk_vcodec_enc_pw_off(struct mtk_vcodec_pm *pm)
> =C2=A0{
> -	int ret;
> -
> -	ret =3D pm_runtime_put(pm->dev);
> -	if (ret && ret !=3D -EAGAIN)
> -		dev_err(pm->dev, "pm_runtime_put fail %d", ret);
> +	pm_runtime_put(pm->dev);
> =C2=A0}
> =C2=A0
> =C2=A0void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
>=20
>=20
>=20

--=-a3j3e/TWQhiEXlEjiWOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaWAK0wAKCRDZQZRRKWBy
9JWRAQCunAzY4/PdIocPz0mGcldjnSIJV/RkIqS9BMGGkQGOtwD+P2Z19p1bMZMu
4dMSY/Q84vZtJ9361u3hPjMZ2jdANAo=
=LCTp
-----END PGP SIGNATURE-----

--=-a3j3e/TWQhiEXlEjiWOs--

