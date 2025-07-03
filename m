Return-Path: <linux-pm+bounces-30018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF6AF7079
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 12:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1FB540619
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4482E3391;
	Thu,  3 Jul 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NgSdbYKW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A91FECBA
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538819; cv=none; b=ej/wI4p/KGcTtCd7CGpwQ1t0qnDiPtLtG9h+66XUqqM213k7yfpXYZCCHyI2Y9RLAfAddzgQViDEFgLg9e3xJ4mseGJ9/FqDfyuaLfcsMnuQUzHHkZDa0W2SloacVZpFYzeGxRPnqm8S84OkMfsGXea4QfTMcZbOCamwLYlnqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538819; c=relaxed/simple;
	bh=xe9m/r2wNEKhNTq1yGfIvhKesACxvY2oAvUudaItXOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMkBaj6UxrIX27NWCtO7ZtdLwGHPOz1fyMFDUty/jF2zyRG/X7GNovEgHgoxBuhcO1sOk7Jh984oBq5YVoYoDmn3ZgbpB8NvAtgEk4YtcoId6DBqVFpC97+gvcQ4c0Z75s/R3FEq0dZ4jwNCYdPFkk/+yFeJqEgKFxLHvIqnCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NgSdbYKW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae223591067so895539666b.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Jul 2025 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751538816; x=1752143616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtQ9lRAm6z5cCoKKpjFUoJ7pNUTxADNFPTG8yUssXP0=;
        b=NgSdbYKWtC1iB97sW90g4jlmqpWTRwTaKuaZkMIwgWJbO9dJZTo39WHco1/oZjtQ04
         WBc3mf7RoOmNkt9wUOyYtHQ2Hqq45D3yvE42j6LJSTGHpJ10ROoW/6fyC9TuSUFPV/hf
         HziW3SdlMtA97glCSrfvaCjifsyAZnkckMzqXgAfD6sov0/znm89nsf3vWIQmCw3GjJQ
         iOsgtx1zNP7KkKqjZ3cpw7STuEHOlHJALy/BPh2JNVA2RMQpgevZUt2dcM9Y2lVMu+hh
         L1ENVHqm9/ktRvh3dg4IBAqUNHxKRpk5CzBX+QpqW4xGMwwzb11ndODRM+IYJM+XO1Bu
         8y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751538816; x=1752143616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtQ9lRAm6z5cCoKKpjFUoJ7pNUTxADNFPTG8yUssXP0=;
        b=vMKugEL6JVrSNaIYWXlZCz0jcvK9ixcVptK9/YoPWA+6w2FZZHDO3VUK8kzfheYJlM
         VwCsdvlXXfBwocnP7dXP3q9j6MzkTMlJnngUzxVh2c3TuWhs2OoaKs9xWRMLqm3WiDhf
         I/GdSbVNunydev9LYStdjtq1KDcpHvii7q+JeRd6LG3ZA41krsD9F1eoXmA2nGejGDwE
         8pOFndRaktk9g9QutFCPTOFVJ0WGYswAuN30Zc6Ll+FD+d3oc3yZtKLeGriHq25X5A3l
         8s9vpTi/eVMA2E94PXR8JwC5/FxWmDLQtkN//+sE+rM7E3BMYYqAQ6Jb+dth/aKuF6rT
         FrVA==
X-Gm-Message-State: AOJu0Yy6vCwlaUpnahLh9EaQ07MmGnSSQX2pUWNCxSrxaDym7wNbvtKL
	ko3F/+tqnMVbsjHkMFtLc43pORDUYlCWN4QVOWtIrV7XUwpg6W463B/YFqmF1uSNCIo=
X-Gm-Gg: ASbGncsCB9x1M4bjFhQP0VY8hjXjFF73YvF3H2pBwahdqLkVvxXGVU2mar19UfN/HD3
	bHgkySlodHUHScTVAJHlfMCX9GLc8YHhAfxlFue/i9Mcr4khsPrmxgV7lldiVmxmaj5xE5ljcnX
	ELWG7UQ//q1XYQsDpPCzNfy7ufOBi1rI+BEC8HJRUnMje67UfRhFI0/gMb794zCe8sokZp4ORQp
	YY4oDSGyT00ZrsSVVujPCv2PHahDm2OIjy3wRxkjbrLHoQB9hitaFvhpDFwjhh1rU3xgtCoMO6B
	HtNK4enWNEmKf2T13QJQ/Yvhu01Blg2IUjjp10ilfSjj5uI50cYrgft2T25kwsFbiSqDUSEdyzf
	yO0yKhxF8sgJzOzK4
X-Google-Smtp-Source: AGHT+IEAH1Qbn4XNukfjtEADuVdGYHRx0aWx0QTiYECTFTYG6zMFHteBb3TPETKc8kywiiMldQNjzg==
X-Received: by 2002:a17:907:9720:b0:ad2:2146:3b89 with SMTP id a640c23a62f3a-ae3d8983431mr230012266b.47.1751538815896;
        Thu, 03 Jul 2025 03:33:35 -0700 (PDT)
Received: from [10.128.60.15] ([81.92.17.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bda4sm1246384366b.141.2025.07.03.03.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 03:33:35 -0700 (PDT)
Message-ID: <fbfc6bf9-d7c6-4df5-85d0-b1d357159d88@suse.com>
Date: Thu, 3 Jul 2025 12:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Forcing devices into idle
To: Thierry Reding <thierry.reding@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org
References: <rlzpjdsg6cbgxc553j6m25ysb6tyldy4lnxsjjn4hdzv7rszpp@y6rfcrbjfook>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <rlzpjdsg6cbgxc553j6m25ysb6tyldy4lnxsjjn4hdzv7rszpp@y6rfcrbjfook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.25 12:08, Thierry Reding wrote:

> Any thoughts on how to solve this? Is the pm_runtime_{put,get}_sync()
> method acceptable? If not, are there other alternatives to achieve the
> same thing that I'm not aware of? Would it be useful to add a new set of
> APIs to force devices into an idle state (which could be semantically
> different from runtime suspend)? Or is this all too specific for any
> kind of generic API?

Basically what you need is what happens when the system prepares to
do a snapshot for S4. However, if you just perform FREEZE and then THAW,
devices will assume that user space has been frozen. You need a way
to substitute for that assumption.

Runtime power management is unlikely to be a fruitful approach to your
needs.

	HTH
		Oliver


