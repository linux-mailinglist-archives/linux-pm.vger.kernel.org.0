Return-Path: <linux-pm+bounces-29150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DDAE16E7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 11:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6B84A4E50
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB5327E078;
	Fri, 20 Jun 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="LGsGSgIV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18E1DE4C5
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410086; cv=none; b=m3xQogcQG1jx+MhZKPIADPgeycldClHurJyalv0csdfTmjXhLrp/dFu9nFd1Vzr+ZXFL1n+FFRgX7YFT1fOGg3dlcG8nlRBCzfBki9koviUdsHx59Ue9EtLm9UzMfylBcPM3Hshf3CPelfXkTLxzlQXPKTTxkhXG5DGNmCepUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410086; c=relaxed/simple;
	bh=YrP2gC6yzF7+01sD+adEWpkCL/eUCTLHQ55D7CZnBEA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CEq4xotKPMBdxszvxVOCvI0dz+pwdfVX3Qg6Dais63hd/+Z226lhcxSWpA5udKCVdrRvXug0LUiwvrzfCBPyGRU4DEv+k53FvCSAHjOz6EfcMeFDg8bUi0KaRYIG7QCEcfXO42ujq+vHIHvbaJU1SH02dGecP4EPMzJpoykGweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=LGsGSgIV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adf34d5e698so555291266b.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750410082; x=1751014882; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSgGeI6RPkNX/6Nx7o+CdwyAntQHm7sGCCxVWOem2w8=;
        b=LGsGSgIV1QOsEbm4P8phGCqfn54CXCS2MA4qCKXCKvy1D+ysntkeA6eUfd6A/5Ub0J
         SiS5GSq1elwhdOwPPSRAF3l74NdM2iq/v7t5LfHzhP6SoZGQ8QgcGTwPF84dCmeqCoVh
         arvmepCP86SAv3phx/hBcXy9RFKLBqRRGU8MKAKjIXlUljB+UO/riQ+7H1xOLMItb4/f
         VDdgI/qCaVpKvVKlhQav5bscnPapHoX+LMfLG4yddlLknU1YY4sOswuZbgDmRmNROqi5
         ZYMvN6XvaZakG5yNZt8q7f2chKhrp4LENsWJcj56Evi0nj3vIJmBQlO6tQkoiYNKn0ro
         MM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750410082; x=1751014882;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BSgGeI6RPkNX/6Nx7o+CdwyAntQHm7sGCCxVWOem2w8=;
        b=rRwH7gqwgRuj/bhxx7MlOMI4VOq91IpY2DbZTQ7zrqzRIueMFbQ0rUxkN469LsPy1L
         /NZIKiY6NNwwNNB5HX5J7rdRnUOYzwV0Q5xb56KdGx+WTE5hgt2Ew9nsGTxIwJrg78kn
         LdOgy/eY6hIStQ7nfwIrX2jKlqrRQ9d92u9gI62rZPzNNTF2UNz/z1/MkfSRWTw7AFSA
         fuSbqupPnN3+sLkJFrQStUjGHia3p6HUsB+8DhjSIm1j5vpqjkoYDdTTrgvlwa+LVXxz
         pQ2ovwx+NavkPOWYtt5Vryf5fE7Kc/lWKU2YrZ0Op1MGUZnf4hfkYgZqDqzOP/X1/YXp
         ZlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTOlfqhEd2MMrdPcEq4dD0F4hVRsRHqIqAfPxYo0NLQIPiU028cbB12Xdm1hPQ5atF9ZcvnNlBVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdT09rv+9vxRLYj7Dx2rlwVHXeApV4zMaXPxWdVhbCBdoueesH
	fSs4L41Mwi8kidFcDxtPL/82N4tzv/5JBaKgX9kDhzCjICVvVXgL6CH760Wt/gA51oo=
X-Gm-Gg: ASbGncsDHXY6l4o8MmB6Q9zHbL/NS8KgEAAz3ef1aITnj5v6RyMEEKY0i9g+M0oi3iz
	t7K8/orSBABDffSyZd/VF8u7KKyN8SkFes0BI/AOrWW5vsHh3w4l3NfbQrcojHXMzIiJkRVt+Vz
	ShtQPgNUXWDPFgI3rLLIlW1cib8nELS+ooj0B9PjEF8UareQrrNpvBt2USy6oVLOMIErku0Wymk
	ysL6Pd0skqagbiy/AE8LQg9Q/D349qdVPh/mEF9Za4tIzJ200KqOTrRj0j4NFca4zCbveuTNvv1
	iWyYHLAXuhReVg3b8bIRKHcFCsyVBsxGiVsuBJMquMTj8rtGF3z5AXyhurWQ72BYFbsmGSEJ7Xa
	TQakUmj1E42TI/qaPh/w/f7aVJS5V7nvB1tMvucZjqA==
X-Google-Smtp-Source: AGHT+IEhyS+3Hkk2TlhfDWZUPUo2xBTpBDeJOyfp0vYr2FDqO4tGaGom5OMtaz2UPfLrKxD1kEZb1Q==
X-Received: by 2002:a17:907:3d16:b0:ad8:959c:c567 with SMTP id a640c23a62f3a-ae05ae211a0mr151097266b.10.1750410082254;
        Fri, 20 Jun 2025 02:01:22 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae05408300dsm129887466b.95.2025.06.20.02.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 02:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 11:01:21 +0200
Message-Id: <DAR8L6C8LIOH.A6EGWUZJ2NN4@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 09/11] power: supply: qcom_smbx: add smb5 support
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Casey Connolly" <casey.connolly@linaro.org>, "Sebastian Reichel"
 <sre@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-9-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-9-ac5dec51b6e1@linaro.org>

On Thu Jun 19, 2025 at 4:55 PM CEST, Casey Connolly wrote:
> Introduce support for the SMB5 charger found on pm8150b and other more
> modern Qualcomm SoCs.
>
> SMB5 is largely similar to SMB2, with a few register differences. The
> main difference is the new Type-C hardware block which some registers
> are moved to.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

<snip>

> +static int smb_get_prop_health(struct smb_chip *chip, int *val)
> +{
> +	switch (chip->gen) {
> +	case SMB2:
> +		return smb2_get_prop_health(chip, val);
> +	case SMB5:
> +		return smb5_get_prop_health(chip, val);
> +	}
> +}

This doesn't compile for me:

drivers/power/supply/qcom_smbx.c: In function 'smb_get_prop_health':
drivers/power/supply/qcom_smbx.c:588:1: error: control reaches end of non-v=
oid function [-Werror=3Dreturn-type]
  588 | }
      | ^

Regards
Luca

