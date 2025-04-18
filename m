Return-Path: <linux-pm+bounces-25710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5BA937F9
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB194471CE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7BC27815B;
	Fri, 18 Apr 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6zGknqL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1D274FF8;
	Fri, 18 Apr 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983133; cv=none; b=U8lhQ0LePpicnBKEjcVQ69XL1AdfGgVI5WfxAl1lv08+DMpKfNmzLxN4sb2zEP3k1gBevOOIWYIih7B2RnFt4NLn10L1QQq2fePlKwXgDoY4dJszBijreWo+/g8Uo375GpcQAcEG9wyvUHoxPQjdvcemHvKZakzhW4KWJxVJ8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983133; c=relaxed/simple;
	bh=b4njmjs5FEWBZVcqpZPtlDiz0Y1JpWUQ2Ktm5h9sD3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qERoZP1M4YEIu1QeAklp3tMC1sSMeyvvqiRfsFvYCNnFmp81zZ5Ra+L+DiwOmwirCHlP24ekMxN70T1jDpJjbM3oS1NT1/Lpal9fFuryLbuPCuWOSnrx9roE23SEpKHG/Ln83oUzWGljnzkR9RkI1yxFVdhsMy/U2c6DdfgLAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6zGknqL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac41514a734so282922266b.2;
        Fri, 18 Apr 2025 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744983129; x=1745587929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b4njmjs5FEWBZVcqpZPtlDiz0Y1JpWUQ2Ktm5h9sD3k=;
        b=a6zGknqLmT56Q06tYSJwD6an0nG6nef6tVU+hdQM+MyadCXM3NsoYLRqQ76x6XuuBm
         Ebj8h1pQRRxb17Dd8IAygH2fONtTxYEsjLFfzhQeYSyueo5ENrdG3P3NIBQzvOFHJjcd
         FzU9vsLB0Se2lUrYIZRMziwYc03acHlSvxKaGJD0i/OmF29fvs/D463Wd3ZOSnUco/qs
         EEr95Keoiz4wvHFkOtGG/ayPWlrKm/xWBE2V7N8peerMkvhoJOoxsLofrgO/HWdUWRvA
         QE48YDgcgx7Cwp1LHgvNL01IcETGhgOVQRVitoRyyZnymOzXG1lejNENX6JirQ9tKbZe
         LHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744983129; x=1745587929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4njmjs5FEWBZVcqpZPtlDiz0Y1JpWUQ2Ktm5h9sD3k=;
        b=nuTc7i3HmhUH3r2vUHPJRv536SWpFGQ309SHP/Nqqb9xuZ+76cg2OTrpxAjl257nZ0
         B26xMz/mrj1DcZ6360au0MOAq1pVsuLFWqMaP29AO9ezXjj70Iu9+cNowtC61A55eWBd
         i6i7RCVttcTDizm+vGkhzoi5w+62em23ZoDn1auSKwauufjFpvTkjyyNk67b53Q7ylk+
         ZzOkCe9MsyjUNlGll3NCnJBQJmCEwB7boKGjd23KX+ad673m/AYhVnRQNVQkDTv3Mw9b
         r8pCb7qLrcpzZnmYZ+NGkW8zGPsTACjDYNDlL4F7d2QDKTz/8nO/aC2pZY/CPb0XNczS
         7QQw==
X-Forwarded-Encrypted: i=1; AJvYcCVz0mrryXxIvgCj9Ez1jlzgdsCkfP8EseA73VvYh0ptYjztRO4VGlCssNlJA71SG1Hf+YBgdKTJrItPxjbdTlf7qvM=@vger.kernel.org, AJvYcCW0GE35MTDBdjmXxzMBd5NEcH+NMLyPZVvE7yoGXe/L+Oo/CSkh674WtPowgauPJuQfL/7sMP2dvKdJk0s=@vger.kernel.org, AJvYcCWh70ArZlCEdhiuPqgPyU3MtTpm7DLQYTDwe3TK6JEbSyTR29zitfKYeII/h91JOifBt0tHv2hcUts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblQxRHVUx1G7WfOHiH1hxjl44ZZ6llele6e+auXEqfBHxGLWY
	VVU/7q+UpPUvnINFld2iOy10vF9C3eNgrx0sUPm5IwzLcDBYNKpUyKRpDfIi+reyTfQ1QESfVVg
	Lw13tGFADi9LOxqAZe09mTm3OfrQ=
X-Gm-Gg: ASbGnct6zWaeEzRwp+1IQw0o7U7LY+darJZvG7Trrgd0p/O5zfaJ4npTl8MAegqUeRt
	+UWbzVX+UjyVD+Az0f94oPru6d7kGM3+mF4mhnM4IKvFiKKkdkQiHsNqtiQC2QcaF8iESospSTN
	3b7IXod8PIn0aH1wJ3vYDS
X-Google-Smtp-Source: AGHT+IE5yZsOitApY6hlFkOYwOYpZYTB/YxlFvfZ57kvY4H+NoJApljac4H2AaCIqMz5qAQqGyh7Um3lY526ikobtao=
X-Received: by 2002:a17:907:7206:b0:aca:d560:d010 with SMTP id
 a640c23a62f3a-acb74e0261cmr227580366b.49.1744983129087; Fri, 18 Apr 2025
 06:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410063754.5483-1-linux.amoon@gmail.com> <20250410063754.5483-3-linux.amoon@gmail.com>
 <aAIJJKGif3i3-97g@mai.linaro.org>
In-Reply-To: <aAIJJKGif3i3-97g@mai.linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 18 Apr 2025 19:01:52 +0530
X-Gm-Features: ATxdqUHZRAneISG_0dWfd2Uk4LjrjEG3JlIyII728_wOPaPTeWkKGUoSPf19fAc
Message-ID: <CANAwSgTpQ32XLfRpbngZkvw4ws_L7t2N6hQY0YNykZgZhGt3wg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] drivers/thermal/exymos: Remove redundant IS_ERR()
 checks for clk_sec clock
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Fri, 18 Apr 2025 at 13:41, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On Thu, Apr 10, 2025 at 12:07:49PM +0530, Anand Moon wrote:
> > Remove unnecessary IS_ERR() checks for the clk_sec clock,
> > the clk_enable() and clk_disable() functions can handle NULL clock
> > pointers, so the additional checks are redundant and have been removed
> > to simplify the code.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> Typo in the subject: s/exymos/exynos/
>
Thanks for your review comments.
Opps, I will fix this next version it got skipped.

Thanks

-Anand

