Return-Path: <linux-pm+bounces-43848-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA7fEvzwqmncYwEAu9opvQ
	(envelope-from <linux-pm+bounces-43848-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:21:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C6223AC7
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55B8C300C3BE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED435CB9B;
	Fri,  6 Mar 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNLCmAag"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735A35C1AA
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810484; cv=pass; b=dQSKQYRHGlwiGFFF+VfCIXt+3wke7KMRFMateR7opPsPkzfs2+Vcci8vXH+T6RANR6NzfEm6ttksVjpyzXct7oqdHV/5icITuZ+IRuu9ZrcrFgUwGekCvme8w/4uwNu/S0bxBAJNTaMBSXo+jjF5fAdD4SElWC8CoqOX7s1Cuf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810484; c=relaxed/simple;
	bh=clDN9Q/ggH6IxCcQFM2Fua/woNyxwC6yrqnlD16EscQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNPUSo2L9Cxv3N36RDV3bv/onv97Oo6o22eJhAa80y9HibJXltLNTt7R6BXibFXLIsrhn2n7MjtuD4mtgwX9PQWaix0s4iJecPrltKAs3jcDbK8q39hdeourseoe8wznuOucQprLMAdk4OSDgAfdEV0Fb8MXeoM43rYjDA850iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZNLCmAag; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b940f962a82so310348666b.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 07:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772810478; cv=none;
        d=google.com; s=arc-20240605;
        b=NlIF80pakWorers9rRL9fs2Wj/QCp72niPBVJJXuazHw+UlwfmvpEZ/Sg/63fvr5kD
         eLuBgf7ntFPS0QXKIUm22epBpfu9FAdwojWcYlF8ctN6Dl0upCyHAq++qciomjmpDins
         PTUS16ZwntwqxOrOuvAO1AVIsA2npE8I8HJplG9JLAuKiovCp6zuGCqQ44h57Td7e60Q
         GYv5zs1xTmRLbk8u2Xi0sxA+RAGOeTEmT2IYuVDkVDOjEMaCYR9r8phm9Rmp1WKsK5ie
         uK35rxMy+8VilbAOSeu5ErOVjVnbEoeuqVX57R1YxhLYlNxq0FY4Vx92k3JHDx4YZzbD
         H3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fVf18GuOCj4KUJQyL5+kDdyR0nQ8PeWTy0/PXRvmRP0=;
        fh=EGficuczL+8l0Hnl+MWOvAX2eSeH1xjc4/I2wqopc5E=;
        b=WWyZVSy20B4gQ8Qape61WmN4DtlmnGbyYllrFF6aTw4VQUm+lnC9lnS/nkSAeuA7zS
         YjMzz0tHoPWUn8KOMaU5zGz5HAEO8nJHxQ9PIP/hp00SVq/1u7Jco8DHkVzdyCtcAmgn
         bN2W/m7cfee3y+mlwhnOlcazSpw11f174N4pygVBg7XY3USzc78WtulZHA5P6Z6Y3bXQ
         KCDqb3jv4QmcUOu/3S2J3ida8lsE+Dtsuc5XjbwNA92zEY62pkS1TXBNtosQnjMCPhoN
         69Wz4iSp8d5OF24zpN07mHmBMJTb3XTepRrnAT9ZN8gjpBipxTAoZJc3mCaW7DY3uKO5
         sXeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772810478; x=1773415278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVf18GuOCj4KUJQyL5+kDdyR0nQ8PeWTy0/PXRvmRP0=;
        b=ZNLCmAagGeCgfsW7k7dfrDPZU9Pz5OCW0dPv84z6mZ8Y7bvXNC2GedgDhbGi+AAMbj
         VfaqdgP7PHzF64KBl/Nvbr/IjhMuv1KZlm5mNpL2muvGt5IauVZ6FGtea+Ru3vz6aZKw
         R+c9U4jxZrQkilY0P6PfuEf48KYvXanQzxvLKHg6cTcE3QWKr+YaWQwdaOETSE+OU+Jk
         0xAb6UdItKQ3zCNFB4WLazMHlieqwHL1G4GdbZtykyfTUBjyU0BGrZD8/ZGlY7Vvvr2L
         yALj4c7O+UsaNjPiw9IR5rJshgvBC+Op8veKALmgpxqOkr4fn/0RloMb4O9YzyGaY8vh
         BPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772810478; x=1773415278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fVf18GuOCj4KUJQyL5+kDdyR0nQ8PeWTy0/PXRvmRP0=;
        b=MJVb03Lr2lvCso4QCtd6f3ziU8yiAxPWdnAOmPvRmsDhYjdprDqXaAOwkJolQMjd2j
         4M/XpvoP47ZMvP/1SWR89kAcxUu7jOUOYDCPX/xU4nUug5pY8YFVixog16fdmvGd5oDy
         G43mKt/39psCyE1sZteEqgf1SifwFjUCiplLN3FSyVpVyLwzN+otGXUrnR/cqGpe0YfR
         FS045k6MY1cxp94HZjEK2+COPo+yvzDQDGcyfQjgxhc43Kb1FeK3osGUXMQQStemMzmc
         PIlWors+ROvL3575Z9ZmDJmCdaMl6EcmyRH9xeBR+x3Vh3AxnVlytiOK6m43aC8bD2xK
         qPCg==
X-Forwarded-Encrypted: i=1; AJvYcCV5nJpJTB6exoKGTjt0oYmwRlTjUoSu0IbrojcNMcvAc1jKobB8/c+nzS3pV2L4Mf/SeONcd0EizA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaCQ5gmY7WHUBKTPsUBZHWRGfRs9z1RNCPucHifiPgyGvoh58
	7luA2ZLr4S1mfBvWcmNu6ebIVifUctTRWDXLaa+umFS5ZG7AfSRgqKNuKbDOHm7ZuBnydoBSwER
	jmBltHGt7tI3U1mGv/9Xxxx3DhRFXveg7pVPoa1PWhQ==
X-Gm-Gg: ATEYQzwzvFLFNLUDaX+LGBI3FrUVD+jplRr/c/15fecUeFvPh5IT8I99jYnKTeLJ3Sf
	MSmOfIxMIRPX+V7nGgdAV8yKPp9RoQIU2NfQM9RjptXKlS5jNC22HZxQ9a+uWcyjeDTYdNePrGH
	kpzGDkhgoVPZMSs3ZsdITsJqvNaWcelP55kZOpCOBaB2CAj69tXhbI+/2yDlc7mGvjDZ75C9W0F
	tSXZ1FprEEGP761Jsf1ajK3+D2M69NGSG7d/ld/Ggw8yGrUameoQVuI+knhTjEM8YWVonJkZkmr
	joYhBcJlo7at8Xl17MbWMmauu+yAjsATCPdBAdeAKQ==
X-Received: by 2002:a17:906:6a0c:b0:b8e:3d49:25db with SMTP id
 a640c23a62f3a-b942e00db25mr143796466b.54.1772810477794; Fri, 06 Mar 2026
 07:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org> <20260306-gs101-pd-v7-8-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-8-03f7c7965ba5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Mar 2026 15:21:06 +0000
X-Gm-Features: AaiRm53NoJSram8HquKNMruwU8Hhr-XYeKCTUDRI7ADZLhZOeyB6oV1YUnbVV6A
Message-ID: <CADrjBPqnf9YVeOgY=uSETnbcQLgi5OY2N3usPOjzJx4o0hGEPA@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] pmdomain: samsung: use dev_err() instead of pr_err()
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4D4C6223AC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43848-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,gmail.com,google.com,android.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,mail.gmail.com:mid,samsung.com:email]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 at 10:29, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> dev_err() gives us more consistent error messages, which include the
> device. Switch to using dev_err().
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/pmdomain/samsung/exynos-pm-domains.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdom=
ain/samsung/exynos-pm-domains.c
> index 2214d9f32d59..41a232b3cdaf 100644
> --- a/drivers/pmdomain/samsung/exynos-pm-domains.c
> +++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
> @@ -30,6 +30,7 @@ struct exynos_pm_domain_config {
>   */
>  struct exynos_pm_domain {
>         struct regmap *regmap;
> +       struct device *dev;
>         struct generic_pm_domain pd;
>         u32 local_pwr_cfg;
>         u32 configuration_reg;
> @@ -47,8 +48,9 @@ static int exynos_pd_power(struct generic_pm_domain *do=
main, bool power_on)
>         pwr =3D power_on ? pd->local_pwr_cfg : 0;
>         err =3D regmap_write(pd->regmap, pd->configuration_reg, pwr);
>         if (err) {
> -               pr_err("Regmap write for power domain %s %sable failed: %=
d\n",
> -                      domain->name, power_on ? "en" : "dis", err);
> +               dev_err(pd->dev,
> +                       "Regmap write for power domain %s %sable failed: =
%d\n",
> +                       domain->name, power_on ? "en" : "dis", err);
>                 return err;
>         }
>
> @@ -71,8 +73,8 @@ static int exynos_pd_power(struct generic_pm_domain *do=
main, bool power_on)
>                 /* Only return timeout if no other error also occurred. *=
/
>                 err =3D -ETIMEDOUT;
>         if (err)
> -               pr_err("Power domain %s %sable failed: %d\n", domain->nam=
e,
> -                      power_on ? "en" : "dis", err);
> +               dev_err(pd->dev, "Power domain %s %sable failed: %d\n",
> +                       domain->name, power_on ? "en" : "dis", err);
>
>         return err;
>  }
> @@ -140,6 +142,8 @@ static int exynos_pd_probe(struct platform_device *pd=
ev)
>         if (!pd)
>                 return -ENOMEM;
>
> +       pd->dev =3D dev;
> +
>         pd->pd.name =3D exynos_get_domain_name(dev, np);
>         if (!pd->pd.name)
>                 return -ENOMEM;
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

