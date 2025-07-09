Return-Path: <linux-pm+bounces-30471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E3BAFE7CE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3671712F6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A362D9780;
	Wed,  9 Jul 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4zvvMFw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA992D6638
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060692; cv=none; b=UIRk68tioJbItynl/nTi3bbM3yvZH1wyqELGiNVZtv55/cf7soybB5Vn+QtoKE6kAQNGtJpbZ0e5/nKiPUjSLYT77Ui2AetFIZjv4eSKqTksvd67YEnjV+FjUDdm7o+RQG7hgIUDS/+jFrjYhRAWov7TBsLqmttZYEjxebZh+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060692; c=relaxed/simple;
	bh=KC3Z6R9qM6d7cSIbmQ52PjX+ds9juhkme3cOPH/FE0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZ/I4e7kB5UXbXwvNh0Z4Az7RYws83b72hgMzlQVFNT/9URndmytyjrMLpxVXReUB14hCbdLDO6HEaPfl8Ak64Q0D1COedWOCEZNnO1s1Ld3U+3fed/v+0wFCPlW6vAYydNvfCr1EyWRP9fUkdOnY2jnHRztMVoNfCovZIly49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4zvvMFw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e818a572828so3771427276.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752060690; x=1752665490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H4qDIkCxD7aqIeJI126uepcAwUwJhAjQhx18iyCLj3I=;
        b=d4zvvMFwQWq5AtwhSFVZlEp2VsvEL4yY6W4uvGlxWtC4VC5WEd916YWS+qtBYC4505
         nJbWun+f95puMGOb8sVtFFdXWhQ+BzYzbxg16VSS8+ZaEfmNWCEwa9GGtOagKTz24KKC
         HsraMdu6Mh4VNXMALvfa0I3NuThWMsEQjdK35pKEmf89rfWM6OphJFs6HVc8zyP7CS04
         FNqUgHOQ6QJ0WG23eVrr6jvL6bYgiTea4NCdQtq6DfUng4s4AjKrhHtDWpjDz7pHZXSr
         P5RiYoAYwNGHLyhWmNOaaNXTNBLu3pYnTovmikJVUehgGPUx8ld4nY8KZfYEnuKEaPgN
         rBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060690; x=1752665490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4qDIkCxD7aqIeJI126uepcAwUwJhAjQhx18iyCLj3I=;
        b=n77YsThu98pfDJIILp0Qd54kStHQCSvgAnsZ856iPBZ/oC0E3BOAITasTsCL9OCkdT
         AM2oZoBVlT1tJKccSLW0xN+Gt4xVL5XQ5hb0FBBnFCZYpw6nsU0qqxCI5ZXjpfx6q3td
         ITfkSQ0NGU9oxdiFeMpLKvhNvogb5djzbZPpKhWinxUguKAlUZnRtUFB9lj1zlx2R2aP
         t6EvXuQGXWhAzbpVBSMYCSYcyBv6Z0X8CFiqJV/jVhpJDiXUPBRtkgSXETHTDj5wEtwJ
         zZzzgEPtUinIQF3G50afwF84nh6u/OZ4uamXBAr0JLSI0cZa+GXdVerI1tAD9fDr9eYI
         FtxA==
X-Forwarded-Encrypted: i=1; AJvYcCWgXxxD7YlFTukrjQ6ddZVlkzmUSovSf2nLjfKP7YxiHWDuJzp3JsKNmQM071b1AJAHseH5IpRw7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpGA399XDrl5Y2oPEoWaOom0FD6yui2PV3AU7crRfD8rGUj34V
	KpdnLjbffM5uZ5CbdABR8NlakR2/yA/VdC20EZPwxvrttIUgI2ON/BWQLyPxJOcrHOsPVlb9FQk
	uZsu/pTsRjHxbyG8w2XcPRy+X+TvvOmj3cKSXsVNs6Q==
X-Gm-Gg: ASbGnctxE+hPOeIStwa2ZCUMqOEPWdKNONbkNTJQYuGs93WMo79VL7RaHRPr3kcD0TF
	DcCTqKuf9qwdI7G/o4DwrYHc9JsN5QIOVE+y0Yk/LlSbHFWW8+V6k2K5jHdDfMDEG9YxEJVeHH6
	k3x8xz6YdQdjqeIkI3eFeaTsTP15mRz8bZDtc1YIg09C2L
X-Google-Smtp-Source: AGHT+IGEJ4mmuKS7rt1MFlUz2bfdy5YmSqNFhku/Q0Up5ig+Hhd1s6mTWPeVIQL/2Z6ktbTHNLkVtt8rYKM0Ty9sofo=
X-Received: by 2002:a05:690c:34c1:b0:70f:83ef:ddf7 with SMTP id
 00721157ae682-717b1ba3c3emr33058457b3.13.1752060689721; Wed, 09 Jul 2025
 04:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
In-Reply-To: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:30:52 +0200
X-Gm-Features: Ac12FXxRo-xD5eCPtXLrowuQGz-kjsQVt_Zu_iyEtrGYNOPit2r7unOQDND3zzc
Message-ID: <CAPDyKFonLENQbafjo621hHPkoWjMNoQ5GRNeNndpezMNnM1=sA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add Milos RPMHPD power domains
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 12:18, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Add support for the rpmhpd power domains in the Milos SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

The series applied for next (with a minor update to the commit message
for patch1, according to suggestions from Krzysztof), thanks!

Kind regards
Uffe



> ---
> Changes in v2:
> - Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
> - Link to v1: https://lore.kernel.org/r/20250625-sm7635-rpmhpd-v1-0-92d3cb32dd7e@fairphone.com
>
> ---
> Luca Weiss (2):
>       dt-bindings: power: qcom,rpmpd: document the Milos RPMh Power Domains
>       pmdomain: qcom: rpmhpd: Add Milos power domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                        | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2
>
> Best regards,
> --
> Luca Weiss <luca.weiss@fairphone.com>
>

