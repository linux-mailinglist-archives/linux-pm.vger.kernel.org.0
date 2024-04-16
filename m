Return-Path: <linux-pm+bounces-6477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8878A6D3A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 16:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA69D1C2234F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ACA12C534;
	Tue, 16 Apr 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leR1eEhX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364312C550
	for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276160; cv=none; b=Shkvj+EjsdSabhDkG6eHuD+rb5dEBge3QvQ5AJwj46zPjkVwBfqi5VPHYiZZg0uIxRfo6jib0Oe0nC5hNPqZW+z0RF0O5Gt2DbpHwVZ+dzJ6Pag2yUQaalTG73rUu74hJXjMHrzXtvHZpWa4ZEA8Qoq6TBh/x8UJzYWk8uAqBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276160; c=relaxed/simple;
	bh=Pn/PAfrTMoBkehcNTeO+zx3SAvKkhPvc7Z2U9JYUOY8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WU5k9oNsIh2T4GfwQEGJiPPclmDnugK3xRThFJfNbcXvCJrgFgGj4wUSMdymrK4oIf2/m89voOHEP8jqWiQV7XT7HPm8ny+tURYxWsu0efGNCAER1y8JvS1ldozksr3Eind/Ku5PUoiJeqcZj6g9pFpZl3cRzGPTYGNV31FuyyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leR1eEhX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c72508fa3aso89816b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2024 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713276158; x=1713880958; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pn/PAfrTMoBkehcNTeO+zx3SAvKkhPvc7Z2U9JYUOY8=;
        b=leR1eEhXSwPeyO1+s3h9HPPtWVMcrVL74xm1JKL/ncTmdrNjjA65XTleXW8Jd0cC4o
         V5xZQrdhY03qyk5ZCwolcomTZB9KobXxOt7v79Qvqty/WzP0qyV6HqstQgDqsd7z4vjg
         //GJCQc77uqbv5r9ErnNcmsBRiytJofEnVxATWB6fFit+gV0mBWi+NRS0negpuuhU33N
         f4vldBqv9uMweIJBcua6at+bWG4875mDkipV35QsOye66HNRVFTckEQ8nnPSlT0dweUt
         DLj95KilUMRmKAweoDcEJF0CB2OgcLp8eZcHWAw1e2LArA7A6Nj5LZQU26XZYBgOw/az
         PUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713276158; x=1713880958;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pn/PAfrTMoBkehcNTeO+zx3SAvKkhPvc7Z2U9JYUOY8=;
        b=V3BAATE7N2oGZC70ewFPDz4mCo7kCiJQ86oQ7ImAlp/pHzjldpxm+BbgPdWHG6XKkQ
         lqHJ3orSebKPabuUG/gYoULnJApTvT3ySTNFK4m8rMhpQEmM7Up/uX0OAdTDUBYWkAPX
         1TtLde1LxbVisdFDRElzx8CuHhA/MLUS2j3i2w0SUfz2/VadfPM8BEL+Q+FGQnDwaSbJ
         7jIgbuTAMYbsFdKXs5g/jgoi0PBI6I8LcU3owbVdSM9urWY7VSnIMbp8d00mPaRczSAr
         7NgEOO3oX1fESnkp5M5TwZnPSG+I+GlypUn/3i5x/wf4kR5xRderwYp31RVmvwEBjsWm
         Z6vQ==
X-Gm-Message-State: AOJu0YyJjXdohPGDEFJlHbBZhuudvuz7Wqi7KvltcJ7SKGfK0j60tlS7
	5GjSPMVJUjH8SpA28m8CjeBnq70LWm1in/Z5z4B8KTCHEgTlOY4+YqYZbgS4/knM4Ybb9dqMkw/
	4nWT4AKgiQouasjmABmqQYF/dmxwLd063
X-Google-Smtp-Source: AGHT+IERSwZbQLrxOmBSuMNvwrZVXORMom33U3OXBcJIrv2RsbM1Ol/mObNvd6Agk++lBfaBUZz7BhYx37Oa/35qGV4=
X-Received: by 2002:a05:6808:2914:b0:3c7:88f:4e87 with SMTP id
 ev20-20020a056808291400b003c7088f4e87mr10044811oib.1.1713276157654; Tue, 16
 Apr 2024 07:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 16 Apr 2024 17:02:26 +0300
Message-ID: <CABTCjFCPRkd80DOWozhWAZa6UrEcbf1ZgTLXqsMjC5G_BEnAjA@mail.gmail.com>
Subject: Should I add INPUT_CURRENT_NOW attribute in power_supply.h?
To: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Charge ICs typically can measure actual input current.
For example, bq25710 has ADCIINCMPIN register,
which holds input current measurement.
power_supply.h has INPUT_CURRENT_LIMIT attribute, but
it's said to be for `current limit programmed by charger`, i.e. not measured.

So should I add a new attribute for input current measurement?
If not, what's the correct way to provide actual charger input current
to userspace?

