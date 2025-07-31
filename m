Return-Path: <linux-pm+bounces-31651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE30B16B0F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 06:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09F43BC33B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 04:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F01FAC54;
	Thu, 31 Jul 2025 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E4NbMG2X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1697A921
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935252; cv=none; b=XWZzPiGhM+mNc2rpAz+zHsvrxnj4s5dXDmPDZHUZ3wkaNLkmW8AjfN0D1qsFO6UvkinnMeRR3sqPW6ngtj29dIAn+pLu2TEROkaiWLVuLQTVnGfqYuiCrlYmkL+ebHP3RydXdLKACjnElHe6HoOPbVsb1GH3C8iOeENfJ0gybRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935252; c=relaxed/simple;
	bh=VYfZznB0Bwd01EwuH/VCVY8bkI+jlyZ0D2t//XUPrtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Of/CMsFnIbBSyK2G9EdSd0oyPuZvrY1uOczSVhYhRHkk8+pkUoNn7XRlYuqha3DTceDAgGXEPBlellXfoxPntXf8g61wCIsj1JoZFI9k3XGQtWFybKfQ0y7AEq98U8rBe7Oi8AuVzCDuWhLIqpMcW3cpvWbLww9m2XztXAmsK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E4NbMG2X; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3137c20213cso658424a91.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753935249; x=1754540049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYfZznB0Bwd01EwuH/VCVY8bkI+jlyZ0D2t//XUPrtU=;
        b=E4NbMG2XPEJaS/ODtV03PDwOIaxpd5ux1oDlMANJb3ftRblZtepRtyI9YBddei9AV2
         faE6tG3PWkhxiBneHMEeTeKPsqrVuq6zLbm1nXwAgG4H8/lz7Elqs9b0N7fjUfTq9I4h
         fyVkr07CLSwZ3ubsg8kSenrSV8PkJpBHOK+CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753935249; x=1754540049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYfZznB0Bwd01EwuH/VCVY8bkI+jlyZ0D2t//XUPrtU=;
        b=GSKSKBpsP4DWoZ06kN99VLO8b53BB+fEIwk3QsWUHCFV41wWJJGLtuD5YVfLr4LnH2
         1fQCilzDvVUCqkp0Q9WmjL5yjH7k+d+KJTQUeXIKch5Ia0C0rtil4Zfq61I89Ew8yoEh
         xm89P7gFH9KOUKekOYU+DpC1XynNaHSZmMVpZ+yvGH3/EG5xh2VCx7jfptpEWyDaq62A
         nsFsd3KubFoOMqqhBQDfwOGCMQHsTfit0JdZC7LspKCdGmws9yGbW/jIBNP2ajgYN4NM
         hbW9sYB4fBRxlXU3w0snEktcmStbEAXxd0sYmtPuXznSrzjzbioI913yl5zJ8FsmcHlL
         4Dmw==
X-Forwarded-Encrypted: i=1; AJvYcCXdpAWvQmCmocPXrGjAOKpN5JlxI3uDhaEv59Cutvd63MkP/cZNFQbqrb/nn5Iza4ga80HBXpS3/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0zm/CC5QRJZKEm28Cf4CG1OUSIPApubwv0WTqKCd5P2bsOSD
	6Ybl3KfxX3o9nsgxwRY++HHY6WvdpaQ5N0TnWkd2GjIRmDwYWDXx/JTaQySVxh2BqEy2yZsuc1P
	QZTE=
X-Gm-Gg: ASbGncuR1J60EIlpPl5g9WRsAQRu9GRDmqcAhv+6iShcMIDOcv/azcp7OlkjdebTldM
	gWmzD/17h6odwemgGVnuMiSrhYQBAIGWBAgrsPF5NhbgQip8MmCmeb2onQSIQNXtMIU3zw8drpM
	dJ5pzOpA8Dg/ixcKWfFKN5itQ1cazTl9F270oFW9GSimcE+K+3qPCghWX91dyQnd94WxrFqSv7E
	kDhxn+UYGOwA3fWMFcKQMxblZe8hjsALv4qbVzEqSAqpF85eN6l8OuFnJCU64uN1RXZl3iTK8e2
	S3fKTE1VgO8GrwosljYcoQVzpzUFkWWHjjwgQ02ESU4SdYVLXupRNt4jlbQImPDQoRpWK2VFAK5
	mg7jtvZLv3pZtagFCjhM0B8nHVkizlh3OrF8BGMGeakDevksX7HN7VLJ6FI/8Bg==
X-Google-Smtp-Source: AGHT+IFq99JaMKx/vhHzeI8Nne1d40Yt+33w8vswFPC1pyjRD5dVKnQ8oRSXF3BtpxkdZ4E5i338Cg==
X-Received: by 2002:a17:90b:4b09:b0:31e:ff94:3fa0 with SMTP id 98e67ed59e1d1-31f5ddb7e8fmr9299795a91.6.1753935248977;
        Wed, 30 Jul 2025 21:14:08 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b4aesm3403345a91.26.2025.07.30.21.14.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:14:08 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2400f746440so5150055ad.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 21:14:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXW/FnBWii4l39+uf0PFo9AQ0Pp2Bx8kTJp8Z0CXnNiWlXqe9xT/kxv8c/D7c2kQF4QY4hqNKOrNQ==@vger.kernel.org
X-Received: by 2002:a05:6102:fa0:b0:4e5:abd3:626e with SMTP id
 ada2fe7eead31-4fbe87eaa8cmr4099520137.24.1753934828784; Wed, 30 Jul 2025
 21:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-6-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-6-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 12:06:32 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj0F-k37-v-gp5A4p3B_R9Q8exM+STb6vLhJ46=oQV6Eg@mail.gmail.com>
X-Gm-Features: Ac12FXzu20jT5Yk4GmMtSAZzZKsOMgulvP8pOesv2GOi_pI-RDe1qMoPgLQDq0Q
Message-ID: <CAC=S1nj0F-k37-v-gp5A4p3B_R9Q8exM+STb6vLhJ46=oQV6Eg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] thermal/drivers/mediatek/lvts: Add
 lvts_temp_to_raw variant
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:37=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> MT8196/MT6991 require a different version of lvts_temp_to_raw(),
> specifically the multiplicative inverse of the existing implementation.
> Introduce a variant of the function with inverted calculation logic to
> match this requirement.
>
> This ensures accurate raw value generation for temperature
> thresholds, avoiding spurious thermal interrupts or unintended hardware
> resets on MT8196/MT6991.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

