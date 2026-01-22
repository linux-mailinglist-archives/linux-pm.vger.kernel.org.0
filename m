Return-Path: <linux-pm+bounces-41275-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHF9AErecWk+MgAAu9opvQ
	(envelope-from <linux-pm+bounces-41275-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 09:22:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9762FC9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 09:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E8AE589AFE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D303481FBD;
	Thu, 22 Jan 2026 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xeg6eAo/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78695481FCD
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069615; cv=pass; b=TI/QI8oCc/o7jqCYknQ899OK6VCKEna6y15xOP7AE+Ffqllwt8cSK5V75ST6GX6KmhQh3/jPQN1qxp0ilmUP3n2kEDSCDs8wT7JkDH6TOerwAdtrCk3TE8uSI6W140D5TNnzYwyi0HxBoETZkxRnLNF55EyPjYuDckvexhmqDkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069615; c=relaxed/simple;
	bh=gA1fM8gWC2kU1633RZk14++WjhCJz+9kYbXpn+DlmCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgX8vTWq2USZ4VbZnwyq3biOvyLYJe+ZKd01QMTKv8dpcFV8caS9c+XgWfLthIMl6hY+KeLy/AVDoSEevXRfKVmtjXgBrkSgUDdpO2jkVkOqN6Yq2G5t7IMqBxFJGCRWlEZWYBWoql3+ZTueuwaLX78HEbATBlSMFgw5KfVyJvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xeg6eAo/; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2670932so590598f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 00:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769069611; cv=none;
        d=google.com; s=arc-20240605;
        b=U/4dxeYEqpFu3Jj7wOW8p+knfjIAxTf4bRErNCsx/S+vW4MCAKXNuaY9DtEbYapGFO
         ezmE9XlRrJZYbalIp7FlDxEmSaZiGHUC6Lu22BxU57y+Wn07THVq2atJbvcwY9qGsHjd
         65MAAeIURV6pVVp0S2DbV+rf46YMCB0qwbIBXoM+E7RgblVhWXp093Opk9z10MJvVTOA
         4gXK+EalI4eYf/CQElxzg74zWZLCwAtk3ipiOczmf6S0ODiNTqhkuKMHg1hVo6uK7b+w
         fPtqbRKT0pZfA5dU0ZzFSD1vzeYUCBqquf8j1itCUVRtWKDfew1pO6TAopLbrUuGb240
         VyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pm4yqmeuRZmAlhNjrdm1JM1bh9K8XbD6fUz4NNp14yI=;
        fh=2Js5XS6nFtB5cr3IO6NztP3qIIT2Rx8jnNJo4+Ynct4=;
        b=XkRQ5C4yGheTyohL4i4tc65Wt9rZxLyx/XsL+DVuccArBmsOzYNQXBbaIYyUazJZeL
         /9lu1QOoDfFeN7xG9Datp/nzcOcpg2D+0w3IeEBi75XHeNNrMWdWCJeWNZjuUVt7IfN7
         b6nBy7inorkTsx4hAn+laDiIJHQlDbiLFaxXckbffCav0ff/Zg0FsBaPKm5UqdqiZ4BL
         LCvy2R8701CCdG/QVzfNqHDNiVb+tM39LQSdV9MIztGUH7l62Kf5DbamdG/hZ3xJTWRp
         k12Ib6QjnNIrEVyB0OaPk0UZF7wgVnYBXD1Tp0FXuYgdf5LIbmegQnkeBKI0EmOs5e3j
         5zIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769069611; x=1769674411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm4yqmeuRZmAlhNjrdm1JM1bh9K8XbD6fUz4NNp14yI=;
        b=Xeg6eAo/e28n3E3Cs7X8BQHXCzPXKtmqkv4wYzIVicqWSSB5LfP9ZNXdqifhWyPH3r
         D1PzZUeAwWRCfpXw4WVjpKHbDP9cAU4KoMFyQKGPbQ8UHesSZ/S0783dHQhENhBJxyGz
         ocCCri/iibSfUJaJvaoLDXeMpYK/0YTWCrblWqKA5Y9tCBMuJOYX6fJyE7XZGmiL6cvk
         MsmEBLzOwUhFIYBNsJBnWDSr2RZUYmv88C3IKW9JCuc7jD1O+JEGhIqA2E+zwNiAOFNP
         i7F6k6oqjMgDv0pyTR0rXHoJhXWiuBLB61OmjOK6Vw1Og41j985zZSWy4kPPBWaUFoW0
         IQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069611; x=1769674411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pm4yqmeuRZmAlhNjrdm1JM1bh9K8XbD6fUz4NNp14yI=;
        b=RbEEoUXa7GIpJiwLgGSjv1Ix8khe4ibtiRpu3iSYSuv4GxFFZUCLauzM/QmViqc6/Y
         IoeG17euU27ICe8jZ9Nv8mYPs8EX+H0sSV2OZ7pB7wtwHdJ618KGHReDGgJUqmv57rHJ
         T0S6NDASk0lsl8DJp4vajFBA5G0yqzf6IWBoLhR8HqGC2xztGSQwa/ES104dEQf4N2OE
         jgMizq7k6k7hrWbu+DKI0iAHuBpht9HvQ+tG8RECo9KtgQbkUSlLaigKiICNmS4SsZ7w
         em55Pwa2OmtE5oBo8WNcH1WPL1Z3+zZSKJ1ABHMusL8UL4bFFt1/sWc+BsB4V5QRV5XZ
         E3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXudF1qIILBKV0FXGUpTU6Ftl015/WRI5+KfzS+UwjLHa0cUtA+XqXmRQjs107wXc8pauHqjx+0mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpecGs/mJPiqzaA8Usam/ficvOhhU1LxpgXAmgzuXsE5YcJNL/
	l0KFdkjDp30SEufKC6nvmr3fatJqTq/B/ruA+a5MSBa346jFExZ+hQh7UrxTod+vfls/wjoQccI
	MgPaIi1TS/s0iNoenasp6qv6wos8srV8=
X-Gm-Gg: AZuq6aKKNf76RGrf4tZmc3TaErM/EAm1Uc1SfgLdZ+TWKnG8hKGHV8052Q65Vkdk4Cr
	bc62iqz6EtdfzOW+AOX/8G8nOG2uGFgZa5s/T0LC0NkiY4s8BxWFZu9YfdjszY5NDYiZz5GKwZF
	5wzwUJTS0IdEtoH5IAIwQE3czxQR2KRukDGLGm5Jmmr6ZbdEpPDkFhBx+u3G+YCsx8R1E7V3jyW
	Kh6PL8KXnDvIPHmfoDrylwQx+R2CZaWCCuqMsqt45MCfXD1Efcusze0oEi7TXwmSuIgR/yB
X-Received: by 2002:a5d:584d:0:b0:432:84f9:8bea with SMTP id
 ffacd0b85a97d-43569bcf38emr30908185f8f.51.1769069610255; Thu, 22 Jan 2026
 00:13:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125120559.158860-1-clamor95@gmail.com> <4370037.mvXUDI8C0e@senjougahara>
 <CAPVz0n1zqo1TyaV=+fc6YzOKH9TqOBEatruZTAVGg9hFEWmXsQ@mail.gmail.com> <7678982.MhkbZ0Pkbq@senjougahara>
In-Reply-To: <7678982.MhkbZ0Pkbq@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 22 Jan 2026 10:13:18 +0200
X-Gm-Features: AZwV_QiXpIIdakCNJ9P5cZK3YWY0HEe71dmYntpj4j8EfRxMZPhhzu-STz_bju4
Message-ID: <CAPVz0n1F3tynph9e6+ts+N9etyGm6fAZGYixW0FCTwOsh==LRQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] ARM: tegra: Add EMC OPP and ICC properties to
 Tegra114 EMC and ACTMON device-tree nodes
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41275-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com,baylibre.com,samsung.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4.44.103.184:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,mail.gmail.com:mid,7001b000:email,nvidia.com:email,6000c800:email,4.44.146.176:email]
X-Rspamd-Queue-Id: 5FB9762FC9
X-Rspamd-Action: no action

=D1=87=D1=82, 22 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 07:46 Mikk=
o Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thursday, January 22, 2026 1:57=E2=80=AFAM Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 21 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 09:56 =
Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > Add EMC OPP tables and interconnect paths that will be used for
> > > > dynamic memory bandwidth scaling based on memory utilization statis=
tics.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../dts/nvidia/tegra114-peripherals-opp.dtsi  | 151 ++++++++++++++=
++++
> > > >  arch/arm/boot/dts/nvidia/tegra114.dtsi        |   9 ++
> > > >  2 files changed, 160 insertions(+)
> > > >  create mode 100644 arch/arm/boot/dts/nvidia/tegra114-peripherals-o=
pp.dtsi
> > > >
> > > > diff --git a/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi=
 b/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
> > > > new file mode 100644
> > > > index 000000000000..1a0e68f22039
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
> > > > @@ -0,0 +1,151 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +/ {
> > > > +     emc_icc_dvfs_opp_table: opp-table-emc {
> > > > +             compatible =3D "operating-points-v2";
> > > > +
> > > > +             opp-12750000-900 {
> > > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <12750000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > >
> > > What's the source of the opp data?
> > >
> >
> > I have used tf701t (T40X) and tegratab (T40S) kernel sources, to be
> > more specific board-*-memory.c files. Timing struct for each clock
> > contains min voltage field which was used to compose these opps.
> > 1390000 is the max core regulator voltage, taken from tegra11_dvfs.c
>
> Thanks! I also looked through SHIELD Portable (roth, T40T) memory tables =
and this appears to match except for the 528MHz opp.
>
> The opp table here is setting the voltage for the 528MHz opp to 1050mV fo=
r the high end SKUs (T40X and T40T)[1] and 1100mV for the lower end T40S, w=
hich makes sense. However, the roth memory table (rel-roth branch) specifie=
s 1100mV for the 528MHz opp. My understanding is T40T is supposed to be at =
least as good silicon as T40X, so it doesn't make sense to me that it would=
 require a higher voltage, but memory timings are a dark art and I would er=
r on the baseline side and keep the voltage at 1100mV. Let me know what you=
 think or if you have additional information.

If roth requires 1100mV for 528MHz opp there should be a reason for
that, maybe we are just not aware or it since it may be not
documented/not public/empirical. I see no issue in setting it to
1100mV for both T40X and T40T since they both can work with this
voltage. I will add a comment in case there will be enough T40T users
who can check if 1050mV for 528MHz work stable enough to lower voltage
later on.

>
> FWIW, roth also specifies a 900MHz opp. I think in principle T40X/T40T in=
 general can reach this but it might only have been characterized for roth.
>

Very nice, then I will include 900MHz opp in the next iteration. It is
always better to have a wider coverage. Thank you!

Best regards,
Svyatoslav R.

> [1] T40X is SKU 0x3 and T40T is SKU 0x4, and these are mapped to soc_spee=
do_id=3D1 -> supported_hw BIT(1).
>
> >
> > I have converted an entire core_dvfs_table table from tegra11_dvfs.c
> > and I am planning to submit those later on too along with
> > powergates/domains configuration for tegra114, but that is for another
> > time :)
>
> Sounds good!
>
> Thanks,
> Mikko
>
> >
> > > Cheers,
> > > Mikko
> > >
> > > > +
> > > > +             opp-20400000-900 {
> > > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <20400000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > > > +
> > > > +             opp-40800000-900 {
> > > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <40800000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > > > +
> > > > +             opp-68000000-900 {
> > > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <68000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > > > +
> > > > +             opp-102000000-900 {
> > > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <102000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > > > +
> > > > +             opp-204000000-900 {
> > > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <204000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-suspend;
> > > > +             };
> > > > +
> > > > +             opp-312000000-1000 {
> > > > +                     opp-microvolt =3D <1000000 1000000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <312000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > > > +
> > > > +             opp-408000000-1000 {
> > > > +                     opp-microvolt =3D <1000000 1000000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > > > +
> > > > +             opp-528000000-1050 {
> > > > +                     opp-microvolt =3D <1050000 1050000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <528000000>;
> > > > +                     opp-supported-hw =3D <0x000E>;
> > > > +             };
> > > > +
> > > > +             opp-528000000-1100 {
> > > > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <528000000>;
> > > > +                     opp-supported-hw =3D <0x0001>;
> > > > +             };
> > > > +
> > > > +             opp-624000000-1100 {
> > > > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <624000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > > > +
> > > > +             opp-792000000-1100 {
> > > > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > > > +                     opp-hz =3D /bits/ 64 <792000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +             };
> > > > +     };
> > > > +
> > > > +     emc_bw_dfs_opp_table: opp-table-actmon {
> > > > +             compatible =3D "operating-points-v2";
> > > > +
> > > > +             opp-12750000 {
> > > > +                     opp-hz =3D /bits/ 64 <12750000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <204000>;
> > > > +             };
> > > > +
> > > > +             opp-20400000 {
> > > > +                     opp-hz =3D /bits/ 64 <20400000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <326400>;
> > > > +             };
> > > > +
> > > > +             opp-40800000 {
> > > > +                     opp-hz =3D /bits/ 64 <40800000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <652800>;
> > > > +             };
> > > > +
> > > > +             opp-68000000 {
> > > > +                     opp-hz =3D /bits/ 64 <68000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <1088000>;
> > > > +             };
> > > > +
> > > > +             opp-102000000 {
> > > > +                     opp-hz =3D /bits/ 64 <102000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <1632000>;
> > > > +             };
> > > > +
> > > > +             opp-204000000 {
> > > > +                     opp-hz =3D /bits/ 64 <204000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <3264000>;
> > > > +                     opp-suspend;
> > > > +             };
> > > > +
> > > > +             opp-312000000 {
> > > > +                     opp-hz =3D /bits/ 64 <312000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <4992000>;
> > > > +             };
> > > > +
> > > > +             opp-408000000 {
> > > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <6528000>;
> > > > +             };
> > > > +
> > > > +             opp-528000000 {
> > > > +                     opp-hz =3D /bits/ 64 <528000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <8448000>;
> > > > +             };
> > > > +
> > > > +             opp-624000000 {
> > > > +                     opp-hz =3D /bits/ 64 <624000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <9984000>;
> > > > +             };
> > > > +
> > > > +             opp-792000000 {
> > > > +                     opp-hz =3D /bits/ 64 <792000000>;
> > > > +                     opp-supported-hw =3D <0x000F>;
> > > > +                     opp-peak-kBps =3D <12672000>;
> > > > +             };
> > > > +     };
> > > > +};
> > > > diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot=
/dts/nvidia/tegra114.dtsi
> > > > index a920ad041c14..6221423b81d1 100644
> > > > --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > > > +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > > > @@ -8,6 +8,8 @@
> > > >  #include <dt-bindings/soc/tegra-pmc.h>
> > > >  #include <dt-bindings/thermal/tegra114-soctherm.h>
> > > >
> > > > +#include "tegra114-peripherals-opp.dtsi"
> > > > +
> > > >  / {
> > > >       compatible =3D "nvidia,tegra114";
> > > >       interrupt-parent =3D <&lic>;
> > > > @@ -323,6 +325,9 @@ actmon: actmon@6000c800 {
> > > >               clock-names =3D "actmon", "emc";
> > > >               resets =3D <&tegra_car TEGRA114_CLK_ACTMON>;
> > > >               reset-names =3D "actmon";
> > > > +             operating-points-v2 =3D <&emc_bw_dfs_opp_table>;
> > > > +             interconnects =3D <&mc TEGRA114_MC_MPCORER &emc>;
> > > > +             interconnect-names =3D "cpu-read";
> > > >               #cooling-cells =3D <2>;
> > > >       };
> > > >
> > > > @@ -655,6 +660,7 @@ mc: memory-controller@70019000 {
> > > >
> > > >               #reset-cells =3D <1>;
> > > >               #iommu-cells =3D <1>;
> > > > +             #interconnect-cells =3D <1>;
> > > >       };
> > > >
> > > >       emc: external-memory-controller@7001b000 {
> > > > @@ -665,6 +671,9 @@ emc: external-memory-controller@7001b000 {
> > > >               clock-names =3D "emc";
> > > >
> > > >               nvidia,memory-controller =3D <&mc>;
> > > > +             operating-points-v2 =3D <&emc_icc_dvfs_opp_table>;
> > > > +
> > > > +             #interconnect-cells =3D <0>;
> > > >       };
> > > >
> > > >       hda@70030000 {
> > > >
> > >
> > >
> > >
> > >
>
>
>
>

