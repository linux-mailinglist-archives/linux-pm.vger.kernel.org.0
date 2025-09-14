Return-Path: <linux-pm+bounces-34602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC8B56822
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 13:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595277A4EA3
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154E246BA9;
	Sun, 14 Sep 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTkjKwx5"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E2243371
	for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850714; cv=none; b=a63Utx/lfHTHOq1VxMrNhAKUbipAnqlT4XhhZpVd+J61YIBREgdDgr/slQImRri2Y/7Uz3mB34y4nHds2tiRKPBtgHzFlZIEzJuh/2V5VOAgxFdGvc7NO4xwu7L3vzkxb70Ley7myN1UIPxFhs4CXNxyMclBIXjQUg1fgofVxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850714; c=relaxed/simple;
	bh=AIPYSOx0428xiqsH5Zw0f1PRbiXpWTgmcLOnuEvukws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAd9rHOrNDdaaMGWSNJjiZtgtha8gTKg59+H34PrvrSFGvwLK2Bt07f5wV54VD27wFgAmebAKRsCGd3jpchnVZutnJptDyBr17OKiN/JWlA5membCazGxpP5sDV+VGA5qLzMfa8GvGhT3FQHrARSt3wAJB2OhiGlcPPxiJZzT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTkjKwx5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757850711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=05ZWoSoCpXTd7kMo2D7eZ+9NOL3Ymr4GMs5H07grvQg=;
	b=gTkjKwx56HG3L/6Jd8p8Zge5zRjHrLS1m4v3+nYZxqxyIOsbJYkcQtSR3FvHTV/3bAkH9l
	qxM5L7Oson5P2UoxpOILEXTUscojoy75ZahCLE7kV9Vdbu3LvHgZOVmSZxYbxRe3a4wz3L
	NfLO7jNYT+bT6OyO50CzINcoKHjX/zw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-cOvGWGbnOJKSXZoDK5cN0w-1; Sun, 14 Sep 2025 07:51:50 -0400
X-MC-Unique: cOvGWGbnOJKSXZoDK5cN0w-1
X-Mimecast-MFC-AGG-ID: cOvGWGbnOJKSXZoDK5cN0w_1757850710
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e5f80723so70672571cf.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 04:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850710; x=1758455510;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05ZWoSoCpXTd7kMo2D7eZ+9NOL3Ymr4GMs5H07grvQg=;
        b=e/nLOy0LlU8SByTTypl9RdxISEJVqmogPaiMMVutHMdAQa1g0uXrq/4G3wbqtTzcM3
         VXaKDEj8u07Cv6vcdQO2L41Bl787toUEvhiTaP8D4D/VaLGhNXmPRp3mYi04+GOnRqN/
         TGiBYf6TfROIqjztLjy+gDV6XfkC8P+knqMDa1OuMrrZEm4harOOplMJ/VNgGiuxa0W2
         +qZ00CRKU9M+heRLwQ2fSZCGj1eYM9dkaGQxaobbVEYAW0vinPuW1BerBF4LAwHBSqmU
         j1IYioFSHPgep7oJfkqXcaVceZlLeuEqFvKLpIu7erSFklkOmJ5B8YWCnUgzAWxXvujl
         3jbw==
X-Forwarded-Encrypted: i=1; AJvYcCU4lvbZ6qYecA8SXOq3uwQNidxID1qdkY32qLm+s7LqAkH3YJTuSlj0zW8VqgJlmvQPW9Y8jUcGNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdGOWPWC/5eXmua5zG8Jq5Hh/HI9Yuna3DnSFiUjY1mUBCBMS
	dT8CGF5Apx5ic3h3EAXZljGAsTe8N54tSEcxvSCqu0RsHZ2ytkPPEPGnu8NEAFGWzXrwf6sNhVM
	53/CK9VHMks85vjIm5uYkIPbMYjA3YsojfxfFi0Ua0nXHcWevpfKNZ6My0QHZ
X-Gm-Gg: ASbGnct8JBp3leCghDDLR5KRWeCaWJ3CNcw8nTf8jGIhCuA2It1Qei9lXc+6EhDMSHC
	dp7J5q4vazWzkkYyIzL+pC5jVlrlykQnyP+AyGAlG0nHC+W+dncZvjx9h0aWbnFECTDlFdPklhH
	tIefcdNzaWSxQvaJG66kcbZlm4MMzwJQCHkpOmE0a6qpoliG+3O6loBeFloj7RyolGhhMpZw3tU
	xH5vcX1T5Slbfn9xEIr0AsNd/uC3gyxEKtzRJYPV3/JZbmKwBRsKI5F132kFRw4EeQq3mHIFcoB
	igG/XRn5QYZv3Wxzu9qJIzaCsit3ujZu+5eFrvg09qvr+1tStWqxQL8VGUvAQuwLaf6kXLuGU1h
	k/GZGyvvFW/0TR2wmWs5XYqhpkRDANtA=
X-Received: by 2002:a05:622a:409:b0:4b4:8eb7:a461 with SMTP id d75a77b69052e-4b77d14bab4mr135163531cf.58.1757850709651;
        Sun, 14 Sep 2025 04:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+XRwnX6jGuwsu4a3hT4crD8COQvyH3Zc5Sbne0Nd2VMEI38oG/sulJqcdFsNqwfss3aWZQ==
X-Received: by 2002:a05:622a:409:b0:4b4:8eb7:a461 with SMTP id d75a77b69052e-4b77d14bab4mr135163311cf.58.1757850709265;
        Sun, 14 Sep 2025 04:51:49 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639da9e99sm51613881cf.29.2025.09.14.04.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:51:48 -0700 (PDT)
Date: Sun, 14 Sep 2025 07:51:45 -0400
From: Brian Masney <bmasney@redhat.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pmdomain: mediatek: airoha: convert from round_rate() to
 determine_rate()
Message-ID: <aMasUV14w0Dc1ki0@redhat.com>
References: <20250810-pmdomain-round-rate-v1-1-1a90dbacdeb6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-pmdomain-round-rate-v1-1-1a90dbacdeb6@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Ulf,

On Sun, Aug 10, 2025 at 06:16:19PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> appended to the "under-the-cut" portion of the patch.
> 
> Note that prior to running the Coccinelle,
> airoha_cpu_pmdomain_clk_round() was renamed to
> airoha_cpu_pmdomain_clk_round_rate().
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

Thanks,

Brian


