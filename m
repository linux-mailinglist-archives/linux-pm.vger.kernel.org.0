Return-Path: <linux-pm+bounces-43842-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP1cN0DtqmmOYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43842-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:05:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EACD2236B4
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE153140582
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810B3ACF02;
	Fri,  6 Mar 2026 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uh3y/Q8j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C1D33A70E
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809159; cv=pass; b=b2K3tsyL692RTFGoZn4JeOWzV9zOaQyDRkLfXLka0pX7TE1RgLwxn5bFeR2YY7yXI0QjRhZHK78UHef69Gt+q/BHq50RuBp5SdCFEZ4w/rCbwt8KeZXbkEn6KjFJ28w2DWYHGQ1JiMY+tOtpwglJ/UVi6EXJFBsHqhzjxWM6hdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809159; c=relaxed/simple;
	bh=RJCqE09FdvoagJuyOFAYOe69yDa97IaYrcydO3qUuks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uC1oQYJcTi3FWW/Up1HSoa9lN4+9twDnT6JbncIbvARqeNqGtG5DEAN1hXhNMVkmDVC9U9EYimEVAM/Dyjocd5Bep2PWz+Y2zL/jZv890/8zvgB+DxIjCaKgCrwNvAl8JlPYDgrM6swBm4WKvlyM49f8b6nhvoko+Y5bh1b4k5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uh3y/Q8j; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56afbcd8adbso763093e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772809157; cv=none;
        d=google.com; s=arc-20240605;
        b=E4lCCeKJSyKS5FAS/iDn0yvHJj3Y9ljhyGvQq+LlHN1OV+skV2p5MNISw5z9L90mv6
         2Y1CHIVknf3KiEaRnly7kam9oc+Qh/kPJNSSc7fphLdSvLDd9rXt3JEo5ombS6NjpWm4
         ceWuSf1lldpS8o4aLFza3b9N3mOIfdU0knaHLPL60RJff1nscokqN+cnyq0pGsDZ8dy3
         rUBrIRJ6fanpn3FLVSiZRHJ0yKGXGTaF9R6VWu6XYskm5y9lsBBcj9nmb/NmujTUNsom
         vLp+PzDYYwmmfg0X6YGIApUtPQKCWZ/hn5beTVAiFBIPc5qXd61RTazvb8wjVC1X7O5F
         IK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cmZqESOyOnPfJv4IzChP40XeUhrwxP8UgJY0WEl1j3A=;
        fh=42/2x0dA0Jkbs4qfpMsZZ1f8zeohmHfTXqR0DuCqvc0=;
        b=Vwez3yWiuqqYeYATd6eRbAjbWNWUZ4S6peOmWVjcTgQWLTb/TT7OofuwSnVZOvl4Nd
         cwu6YNaH8mz+R5457vas+wx29oRC/BQ908vIUvoNUR+D/uB7liSAqr8J4TpZO77rz6xs
         3DZrysdHKTt/FZGcCS+wQdqa3Vz/uE7dCTZRhfzHmzByd3GsTwGVJlhpBFo8+RlwhLA1
         APfYznBFRM78LzEE4LpJ49TP99XbeaIhg845Vv83nhFyjT6BsEGZ1ICFwA/sCX1XcddU
         QwgUBja8fWFHo4STRYWm6Q1StUR1W31uhrFlDFB6POeouSlKCe1g6ggnn9Tyg1eMhFgA
         UXdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772809157; x=1773413957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmZqESOyOnPfJv4IzChP40XeUhrwxP8UgJY0WEl1j3A=;
        b=uh3y/Q8jKO716zXfm9TQpIODe5Qm8XBzdNfWXJMZCctouQOxtEEEsAu7jCJlCRVF5U
         6Kz8DN+5UE1jPL/xl5gnUWH1BOuZzy6KCVjxj/Eo3l+S7N6BWHvBA+kRbEl7DESvZfhj
         oM+5nUbC2Q3SEfD1vYNR/2kKda/GoHiOxNQK7lLqmxDfUY4mkS/LkxuPVo1WPFuQGSeV
         +piDXnshjH+ffTzrRm2Vn+7dS63tWWWQzlmhNrHMtybt297ffjAKt57MrGi5DHPY4L0l
         Pyy0RvvOn+5Y4nxcT9l2WPsD279Ry07MEPuY+Jvu2l8Ul6UAHoqxsV7sN4NkFDSuKkYW
         Mv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809157; x=1773413957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmZqESOyOnPfJv4IzChP40XeUhrwxP8UgJY0WEl1j3A=;
        b=QymNrdClSJ72kywLmz9/0l4Mms/XfySMPlYauh1outgfmfjVELq6/rjsf/4KlSiEuH
         Me7fKD/sg6bk5Wezb3bwCz90AuhxYic7ZzKXI3fWB7iMigy+UMYW2GnNgC84rU2U8k6C
         BFqWshvxgpL/7xgEwMoK8XX7vzhOIf1cLlVSHRZe1KLxl59cCn9Fc8DNaD3NjKU7i+bD
         hii1wvdGR8yO0Li+nZUBqzOHkk6hCLFwIhi7n+/IZ2IIUY9gwuKFUF2vaN73m38rhG8S
         gS34+b3Tg5R3B3VqeOsGF94DghoNKhi7gLAgEbx1p36dSQkSM1cCoJPf84Uu3teNAthF
         uVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpRjXRalYK8nSwV8T+MP3ShvnhKtz8LSgUMl+59SNXdi1Yz2BjbpzvqrBOyufpu6Www7Z8Zqx74Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUk/tkX7Q1KMfDXsA65yaGVt9qi3FHPxH95YeN+vv8PvCXuDmF
	Ffh8h+CHXcvnOpwOmC7C7fiH9FdIinzze5cau0CkOhj5NEktcPRTtAApf7QHSLd18gKZNIPT9jw
	N0HhHP9rBgC4mvfPDnFLL0U4YHlHcIZnOFHxV3lR3yg==
X-Gm-Gg: ATEYQzxatBdmm/+Z1W4XlARitCM7vu4lOhlOkq4PLFO+B/esqeLi4Dys4hH9svoHYaP
	g75pUTi4hmgWqFF20ZyEvySHWsY688ijwMNiY42V/cfrkQTPeMgvDCp/Xmj9oCf9D2tu3xuq7ph
	A9YSFRPxconldGLh4e9m9I4XdoHstpYkNg7RLk8LG/vdt5Qur1VLqxnBZeRPCFJMhLdzWejOg3g
	g7DBA3De+q5ZZtVnqe00oXZeDHcOabjplo5xB0zbkdJnxkcpo/gBCs7wOJijZgRpIYzUOmqDVLr
	bCY6xOkcChfTEaM8N2LyDpvSJkEUM4y1DytLtD+4/tyFZgwGCCWB
X-Received: by 2002:a05:6102:c53:b0:5ef:b5fc:dd48 with SMTP id
 ada2fe7eead31-5ffe5f56879mr715168137.9.1772809156599; Fri, 06 Mar 2026
 06:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-1-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-1-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 14:59:04 +0000
X-Gm-Features: AaiRm52b4ufIqeiRHiDfo_C1HRG2l1W5rj2t_mcLn5mu97dz8SMCboLZ3LDBNm4
Message-ID: <CADrjBPoceGbH7Jf7z=8icaM_6c2pyZBXDf7-uxr2gsuNSowSEw@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] dt-bindings: soc: google: add google,gs101-dtzpc
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3EACD2236B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43842-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.167.255.208:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devicetree.org:url,mail.gmail.com:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:29, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> The Exynos Distributed TruztZone Protection Control (D_TZPC) provides
> an interface to the protection bits that are included in the TrustZone
> design in a secure system. It configures each area of the memory as
> secure or non-secure.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  .../bindings/soc/google/google,gs101-dtzpc.yaml    | 42 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 43 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-dt=
zpc.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.=
yaml
> new file mode 100644
> index 000000000000..a8c61ce069d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yam=
l
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/google/google,gs101-dtzpc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Distributed TruztZone Protection Control.
> +
> +description:
> +  Distributed TrustZone Protection Control (D_TZPC) provides an interfac=
e to the
> +  protection bits that are included in the TrustZone design in a secure =
system.
> +  It configures each area of the memory as secure or non-secure.
> +
> +maintainers:
> +  - Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: google,gs101-dtzpc
> +
> +  clocks:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/google,gs101.h>
> +
> +    dtzpc_hsi0: dtzpc@11010000 {
> +      compatible =3D "google,gs101-dtzpc";
> +      reg =3D <0x11010000 0x10000>;
> +      clocks =3D <&cmu_hsi0 CLK_GOUT_HSI0_D_TZPC_HSI0_PCLK>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0b879760b6e..611fa8fb9f8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10883,6 +10883,7 @@ P:      Documentation/process/maintainer-soc-clea=
n-dts.rst
>  C:     irc://irc.oftc.net/pixel6-kernel-dev
>  F:     Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
>  F:     Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
> +F:     Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.y=
aml
>  F:     Documentation/devicetree/bindings/soc/google/google,gs101-pmu-int=
r-gen.yaml
>  F:     Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
>  F:     arch/arm64/boot/dts/exynos/google/
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

