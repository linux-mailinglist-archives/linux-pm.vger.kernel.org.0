Return-Path: <linux-pm+bounces-29148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489BAE16B3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5E916C671
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F980274660;
	Fri, 20 Jun 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="eElRhdTF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4E254AE1
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409476; cv=none; b=qeEwk1o+wNgP7IJ1vN//uyLsEGAGhutHK9iIABSzHBdGITNfQYlNCeMunrxgd6F43fYm2yBwiYMyjZg2HFylQCZJmWQElgxvglo3ZffHStMlDEPrp4AAnpMFpW2ZedF8wu8v5VggbYbPt6lvvsWZCfmiR7cWXbsxt00x2Mxjm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409476; c=relaxed/simple;
	bh=41+NV6wm7M4BUwGUu5BfX6Y/1mglDykUJq2/D+L+bV0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=muOWgVMoTKDeMCEZWp13sIigNzhzluCQy+fofFu0Hbw9jQ7FarJxOp2HLOOycF4S5wbmtQoRM+n6yYKD2baeQP1dc6htpX7pg6Jq/WIODnZ5VcdcApdf2mhg3jwj9bi6zbJDSCg7ORseWuW+3GIgye95DOnV4ncJC6m9LRbKl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=eElRhdTF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so2327719a12.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750409472; x=1751014272; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQs46cNDxNcEM2859ny72mW8pcAVQ7BIEu+RAnGt+Uk=;
        b=eElRhdTFqyfet3zX6SJ1DemBoJg/QYIVepXir4utb5zKu3ZxnIQpSDe8Wb4f2IeYlv
         c6YoNmHPjPVqMTBfMpoup5C3PIFs+jAuldaiJy5wWPS/o9WohoWF5sUO/2aRQPS4lgky
         JxhAlYByweTDsfqvJ8OGmK+gNOvF48TvrdZVnH58kMiaVh4njA3jXSfF2AunQzjQ5jKq
         COLm+FZQSG4PMPsfsxeCNYl6mbsKwLSBCVrU5ms9jJKSiFYiMm1fBJbYLNhBA8yZeGXJ
         wIiMp7w4tAcggmF3uxO1ArOmUCHu8FHJSIyhKJnYGXi1XZ6cbfh9mWnlJlxunJ/kqXr8
         3KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750409472; x=1751014272;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tQs46cNDxNcEM2859ny72mW8pcAVQ7BIEu+RAnGt+Uk=;
        b=rbsMASNOIcFkRgbkJ52SwkrZQ1ViM1tNzEXU34Jis0qiogqSVzAuz8HvDZbKps5xbl
         t37LAT1bnvMKDO3dj8NCKfpMSz/Xayp2VupgdS9z5s/O6JqWVl20tg+5pOSi/+RKBbM+
         gSHsb65o/9OIo/x45YfX+aDEmQ31OneiMT160h9SX6jsifwbps1RXJq2vUHnKx37e9rH
         tFfrli8NhOQnCu66I275cs4gVVAFZts71+3OdbjYHFZyNdep8YWnFI97q2ay4zKocQwf
         c7tw5qV53LLUn2ShCVV5CP4S2Im9jzNW87O/ILx4x3iPOVnbHf3rYA+J/JUtGyR6BBOf
         EGSA==
X-Forwarded-Encrypted: i=1; AJvYcCWofpcLWJv5QREgRigUlL5/ShND+k/gznCK9264A37OQuz8TIyko2j0G/KFoax5e1JodpSr/ygpyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhLo0snx9P/pSWk2dOkTPfrt/QmX4lt+2fqRGPqaoudei7BKw
	OgfzHSklDhyBcFuOvq4Oe8qwXUJYwMpGhCo3uPi9YxvEpHQzvBdcDTdNFEEgys+5jXE=
X-Gm-Gg: ASbGncv6XCtKeJtzk5WX/h4r4ddDkIWZ+rG3rMmy0DU4v6dSSwZAnQ4WNlwmiJ8eGt6
	GEna+F9xamNQuc1psUEBqKlFQ2+o6cmr7vIY6bYyUHfVV708jrOE1ordulPGxyiF0W3wzAJJnwW
	N5NXy3Jyv/5u+j9qoJBE3UXv783c1HKEHlouQ1MNMtrWte0xb7HURqmE8Ken7hI8TNmXO6zno+4
	eOD9MiCPJks5ip9jW8AvHdhL4E/U9KYLjjd0YgnoQbXm70FlVh5Kk/2cQOFwwhbzhIFkYkhVv0Q
	laNNviyXfb3GCCSkVgXAjSr5nES7UZRkz08/y0N1YQA6Je8p+cr5KUk+jJ5FLA+1O92LZK/IvTJ
	0+20IlmdtMCcpc2Nn0zcIhdQ6BNbIlgo=
X-Google-Smtp-Source: AGHT+IEmFiflCY72gns8BJi7+wHzY3UkumCt6vc+CYitRi/cG7BsMF02qzVY1w31/s9Tg+2mrG6kaA==
X-Received: by 2002:a17:907:f1c2:b0:ae0:635c:a400 with SMTP id a640c23a62f3a-ae0635cad5cmr13076866b.51.1750409471648;
        Fri, 20 Jun 2025 01:51:11 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541bc9a0sm128495266b.146.2025.06.20.01.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 01:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 10:51:10 +0200
Message-Id: <DAR8DDUQ8HM7.3IKL9TCT7SJM3@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Casey Connolly" <casey.connolly@linaro.org>, "Sebastian Reichel"
 <sre@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 04/11] power: supply: pmi8998_charger: rename to
 qcom_smbx
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-4-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-4-ac5dec51b6e1@linaro.org>

On Thu Jun 19, 2025 at 4:55 PM CEST, Casey Connolly wrote:
> Prepare to add smb5 support by making variables and the file name more
> generic. Also take the opportunity to remove the "_charger" suffix since
> smb2 always refers to a charger.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/Makefile                      |   2 +-
>  .../supply/{qcom_pmi8998_charger.c =3D> qcom_smbx.c} | 148 ++++++++++---=
--------
>  2 files changed, 75 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..f943c9150b326d41ff241f826=
10f70298635eb08 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -119,6 +119,6 @@ obj-$(CONFIG_RN5T618_POWER)	+=3D rn5t618_power.o
>  obj-$(CONFIG_BATTERY_ACER_A500)	+=3D acer_a500_battery.o
>  obj-$(CONFIG_BATTERY_SURFACE)	+=3D surface_battery.o
>  obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
>  obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
> -obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_pmi8998_charger.o
> +obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_smbx.o

While you may want to keep the CONFIG_ name the same, the description
should be updated, at least in the SMB5 commit.

  =E2=94=82 Say Y here to enable the Qualcomm PMIC Charger driver. This
  =E2=94=82 adds support for the SMB2 switch mode battery charger found
  =E2=94=82 in PMI8998 and related PMICs.

Regards
Luca

