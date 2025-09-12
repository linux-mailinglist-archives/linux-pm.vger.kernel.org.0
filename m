Return-Path: <linux-pm+bounces-34542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214BBB54A12
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E94918911F6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858D2EB86E;
	Fri, 12 Sep 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wpec/RD9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E110283FEB
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673627; cv=none; b=YvekV0/+lU/Yn+8VmbwOZdUqA1ZUIfPeJFIoB3GmqN5HTcWlF97XAKxQ9vV5qbezBtlx1VvHsnXJ9AcMrDF8XYsPza6mko8ubH5Tillsbg0PGm5OPI9W1+DhxnLmSsD7VO3wgLt/TMhNIH+m+Tcm3lDE3ocrgjTKJCHNcKvRfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673627; c=relaxed/simple;
	bh=3e0QDJ5KbEQSENJLgEWoOKXZbyZ1RrVyN7WOTZvbwFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt9QlSPhpCLvNSh2DjVSS7OPBBKJ5nyCqyxrYc+ABj1sZySXUIKUW2Md53jNxav+DXGd8fc5Sr6b6dVYbNC87fGyZFAU7OABcrmRKjE3EyFG+yDM2XWNelmSphHr48j4RDGMw8sWOuYiUZP4ch2jRsoBmmKHGFDC/4t1CIAtCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wpec/RD9; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61ff35a56d3so924584eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757673624; x=1758278424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3e0QDJ5KbEQSENJLgEWoOKXZbyZ1RrVyN7WOTZvbwFo=;
        b=Wpec/RD9qi4TbGQy3FJL1NA95+USMHmuMtbEHsw7oAhhUEYMS4urGz5OrcIxeEIrAn
         2a/BibT7iJtbHbxMYqn2i5IlUC2aXIVx7OaMabZzZw6kEil0SMpXoXfSX+H3iw0JJzL+
         9luibtddZn9SwB4f3Poqzhvh6pgbGlvOzwfG9iF2d38mqL4vw5sdnX6yFrQYXz5bBDD4
         hF33YdF64eDbjEF0ly0m+Zd5tl3NtDbkzpCAYlDyURiyrfnBG5bFo1Jv6/vrCqvvBMSH
         IdKT40H4Zwg5ynbNmByiOm0tuA0354YVoHkt/mHI2Lg0eIxoOD91uulP9i881j+EXp9M
         3SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673624; x=1758278424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3e0QDJ5KbEQSENJLgEWoOKXZbyZ1RrVyN7WOTZvbwFo=;
        b=Ey/yNF/b6Z2z+YQxpuPGYNTHAaXhja7ZcD49hgWqtNI0OwqRU6XD+5kSkWVPgJYfWO
         UNjDvKw/mz9LtW2l4Re2dJbs+010Egt6szsByvr+jsf9xzR8SALK6UgtzG2gjYgsWqoS
         Dsa9AiXrMg/f5Bg6IgCAiBj7LhfwxWKDBIhkK9CaSvM0i5sknCA2PsdOsGNSzA9vyZ1w
         b9be2d2SfdvUBkZXmOdasawE53G61IeNAU6UljNSx5RSYEfN5Y0v2gGf1XY775SQATxH
         O9y0snldx9DbilYGyc2SqqAay+MNVX7NBXC1LSra1rbx6+PlCKy8WpONtksaC6ge78CE
         OHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvSyeRn5VKWHnt6kazWP9sNKnzB+LeUtTfpFhqjlZCuTyzOv4pmdtnpR61/gj0Xc4Ns+KZKJntfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtkKI9bI+j9pXaLYEaHHFNfzVilZJHkK5UHhTXYtkMi6tL+W6
	XSkp2/cBgnA4PXRqH5q6kwTLLL5c7aUtUYdUiaVA0oYK8ul++kx6txnb7Jq1y7zaEaXD7d19YF9
	4zhFodlvvRlxNVo5H5uviN/V1h4HE4mhTEWvJ1DYpyw==
X-Gm-Gg: ASbGncvKju/BWzWSiH45JQ4/7huUpzH2aEdThN4OB+uNLThaN5xcLvAORSIemns6avV
	FqfHMY7HPWOn0RvLOoOAZjCvXJ77HR35qBmhTPDzMGitlMlu2foQ9q45Zhx5iUMVX1rofob/gz7
	MS1TFZ2os0VPGI8Lf7XKLyukQQlPgrqrAawJvmNiWRHaAo8Y9LXjaAugKHwBKWl5AoUBIIEJkdu
	XXqbgdBVnl905TbDA==
X-Google-Smtp-Source: AGHT+IF6PYieNgXpIa6hYHoBPz39MBN51Z0tSk5VpF01b/bxMjrI+5a5IB+fKLhWJ9leyknO44l7JDgMdXYIXbH0W9U=
X-Received: by 2002:a05:6820:553:b0:61e:154c:5b01 with SMTP id
 006d021491bc7-621bedb8f94mr1279631eaf.6.1757673624624; Fri, 12 Sep 2025
 03:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be> <20250804-b4-gs101_max77759_fg-v5-3-03a40e6c0e3d@uclouvain.be>
In-Reply-To: <20250804-b4-gs101_max77759_fg-v5-3-03a40e6c0e3d@uclouvain.be>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 12 Sep 2025 11:40:13 +0100
X-Gm-Features: Ac12FXyvumHdbJffBuyBixni6c5DHFCVdSez0KdSftksCT_bGFTh8Q4itCgi8Pg
Message-ID: <CADrjBPoA939OwErqjV4OT04hgAfDNgmG2o582Q_P6CN6iWQgCw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] arm64: defconfig: enable Maxim MAX77759 fuel-gauge driver
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 15:25, Thomas Antoine via B4 Relay
<devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>
> From: Thomas Antoine <t.antoine@uclouvain.be>
>
> Enable the Maxim MAX77759 fuel gauge as it is used by the gs101-oriole
> (Google Pixel 6) and gs101-raven (Google Pixe 6 Pro) boards.
>
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

