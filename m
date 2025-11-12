Return-Path: <linux-pm+bounces-37882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700D3C549AF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 22:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C393B8E06
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241042DC791;
	Wed, 12 Nov 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMbd1t3d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37272D9EE2
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982048; cv=none; b=Pc2zB+9BNv9E8w5ijQv9iCnr9XAipSs8vK8J47TejFnusW722Bj27Ov0vIQjCuXfBDLz75Zsb1k3Zr/5t4rm++VoRSU1Ddl0YsAag6XERknRSJcQh/NemBvJHwjDFIg5nPrEiXhrku7qotaYO1BtfPzBi2DWr3QPoLuTm6PKmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982048; c=relaxed/simple;
	bh=d9CscdDYoao8HLVGid7qesd5VVIUGE3ZUvy4CEqb3i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfJn3hHmHmTKErJ6WUO1QZTQr8EsPchT35nwDR5Tz6XTyaAmIrDIYuNXjAXPmvbLFREN25bTagJlbyx5EVkTtFBLKTxCAaK8iKNlO4Uk8rVOYlPYP185LFias4WDrop4yxb9Q3BDcJse5bM8oT93NGHOMaFzRojq9WJ27AiCoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMbd1t3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A988C19424
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762982047;
	bh=d9CscdDYoao8HLVGid7qesd5VVIUGE3ZUvy4CEqb3i4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rMbd1t3dQAZKvP1P+dl/+/3pkuELjMN3JotqSxAuKEXEwr2f4ewnMB+CBjX6PxESq
	 GH2G1wovl8X6X42l6xFChpTx5r8Ih4yMC25kq490tyji5qE6bWnqzjoR0zVTeRbzJQ
	 dPM1vLivzxV//UxW7dpJ673mNpOSzeh7DufOyG81nC4ehBgiCiRD76lRaPR4IVUsnh
	 2a2GE4WZfa1T7ih5lKTCY1w9EBEwK5ifNWXpMSZ40mOKxRJEzGfTOivqLr376LT0Xo
	 DJh2uVA/E42QWsh12WOL/BkyQ21kHuQD4815fmmDSlkfoDhtTPO6pwsPN0PXEASTqy
	 GLFuxizjryb9A==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso7765266b.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 13:14:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaTPT5McwdCcriVfTxac+1HQYTHTMmbPlF/UrBS0zwny5uwaMUtfcZ93Z+6KFt0cyUH41fuxx9QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLCvA3wSUfSR8hyYAzjfbeX6/KoWcrLImRhWpL5DcC6mIhilY
	ia/PdOmmzW33oUXOdzJDH/Uwj77CXeKjFxH94QDTz9Rj+qq3RrrxbnpDwXGQZcUeqPpW0ypGSsr
	KY+KJEsoqk+TCMfCKciTiPWFIjzEnTQ==
X-Google-Smtp-Source: AGHT+IGoTsQoCL6ji1eL4R4EPErqkBB9/ZPpkzWQ7QknL5cqA3ACnTP5l2VR8ru+GLXFcCnF3dsP1vre7ovgV9UMEbI=
X-Received: by 2002:a17:906:38ce:b0:b73:4006:1882 with SMTP id
 a640c23a62f3a-b7340063656mr148670166b.38.1762982045993; Wed, 12 Nov 2025
 13:14:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com> <20251112-pci-m2-e-v1-1-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-1-97413d6bf824@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 12 Nov 2025 15:13:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+dZOUCosma1QJ-aqtjWs4NDLRkAdB3Aaro=8_Ep7Y0Rg@mail.gmail.com>
X-Gm-Features: AWmQ_bn9JcCoc3dA8k21kD5vpGQMTEoPaksSR81OwmvZvJ9jTIsLpoNTgRKEaZo
Message-ID: <CAL_Jsq+dZOUCosma1QJ-aqtjWs4NDLRkAdB3Aaro=8_Ep7Y0Rg@mail.gmail.com>
Subject: Re: [PATCH 1/9] serdev: Convert to_serdev_device() and
 to_serdev_controller() helpers to macros
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 8:45=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> If these helpers receive the 'const struct device' pointer, then the cons=
t
> qualifier will get dropped, leading to below warning:
>
> warning: passing argument 1 of =E2=80=98to_serdev_device_driver=E2=80=99 =
discards 'const'
> qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> This is not an issue as of now, but with the future commits adding serdev
> device based driver matching, this warning will get triggered. Hence,
> convert these helpers to macros so that the qualifier get preserved.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  include/linux/serdev.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 34562eb99931d808e885ce5022b8aa4577566885..ab185cac556380dfa3cdf94b7=
af6ee168b677587 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -49,10 +49,7 @@ struct serdev_device {
>         struct mutex write_lock;
>  };
>
> -static inline struct serdev_device *to_serdev_device(struct device *d)
> -{
> -       return container_of(d, struct serdev_device, dev);

See container_of_const()

> -}
> +#define to_serdev_device(d) container_of(d, struct serdev_device, dev)

