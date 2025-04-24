Return-Path: <linux-pm+bounces-26128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076AEA9B300
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 17:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F85A188548E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40A283CAC;
	Thu, 24 Apr 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyfcS3Kt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404E284681
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509814; cv=none; b=j2KuX0E85UhpQs09+BEdOrPYan1MsfkqyQBEqgjJgMj/pFAC016D7v8ufHlRNla5uPw2AfH6Pvbw61Oq2fic8q+GVJg9U4hAE/0H0jsdWi+79ruYtdnvJtGGaMJkq0C34lJdBse4NTvVZbV7wLS5XpKxuYuJPii6rg6xMtbmE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509814; c=relaxed/simple;
	bh=wusSUSsyO9XS4zcv7lbnV0naAjtGZzYLE8DZ40kmWK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOV6W8aJ8sR/Mhk8ewqR1CUmOsXpnKoqD8ipKeoHUi+v6YqUScakjq41HwNZes1UirT5ygCIy32sMuIUM9Zr32bv+AHzrh9cT+uliiqirMy8KvRlxXDiOidc4rb2rjQ4YF+CaH0+YbvP0buvNEdtofmi6ChJ1MFOJJQWZL56sGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PyfcS3Kt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c277331eso2349668b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745509812; x=1746114612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe3o8pVxhkRIdSBJ1zIBOU2qAC7JzCU4GPoDvO8nsGM=;
        b=PyfcS3Kt0wAYmrfzTEEGIh8Og8wUcpbUgKXCPeFS+Kt8Ns/NVzobGF+CeDw2rZfjjo
         KudLSYpKsCjQwLV3ieC5UGmbcPDEX1j/POAw3bJoocQ081wKk9+Cd1rpPP+nmI2F/can
         XNTTMj544iH61o5GXzNjk4WwyQn4BYB5yxQdCwZ+6bj0r8xAIEZ9Y9UGK9VQEv0S5Mtg
         /MeQKlqS4vFSrzxD37weE3do9j0EZAZLxPimrhzgD7tUFWKUB6gX95L1AOJPlgcfv5qN
         yInvYGkvRFd9QtwaarxcZFM9thgIO3YlUOOmdsHqfVlLPGabJwYqLjoxHac0GgmDABSa
         3S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509812; x=1746114612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe3o8pVxhkRIdSBJ1zIBOU2qAC7JzCU4GPoDvO8nsGM=;
        b=ZWUJ9fINOR9eIW7E0zHDyAlBDDGDgofBG0RHkVuzSzZ5bDPqhSpdC7TuTWxQ1dmS/v
         XEPuIYcFDfxlpMu+zbkgrPbjeRGnU6tlibLQMxK1+XT/k+vQxGS8mYViswZZnB2APrlZ
         f2sI/p4JfcIRzLhTM6hJFni4D7jAEcHPKkrFDizkLPXXi3y0CdDcS4sYkuTudF1vJpNw
         CTckVLkcc886y5moO0LMz6Pl+XZoH73g/i7VGSUlEx/87AuseAtwu0nHMcnAFwQ0t1A/
         srdPgSkAAHyTT5s/dpxm86P+ZtbZCZpQpkDSjlOS7O9YUwRQKM75e3aX2+8CCdZfHD4Z
         SXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvGhwmmHid9G7XUKUk2Zi5l2VUwdVRsj9pNhVsYsLN9UlHcO2HOZp9cIdKeeMnwy6y7GVE4Q7CgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsvsNHLD91UaO8kZbxHLOfx35nYz9uW+ATPzrDAmw+DAeblGM
	kufWggW+rzl1YSrAH+H6++IvCDwWVqPBAL20y8IsOpt38qppTxV/dXtYyd5+gDM=
X-Gm-Gg: ASbGncvf6e4YCVkYveAkkUVnaAJ53Lq7Fr1QGF+g+d2Ed/VO8CbwMIQRmxBGzdn4W1e
	qC7GbFbZ6lmSJKBW5B4hutpsqz/wmEl/H7PrM8/1gVvkf28YNKPdgDEZaymMARnQ9xqiFP1kkCc
	6h63jcAIkSKAY5mISZWJZrdT5asVTOTr79UapCAHafS7oZ/46ctdM3760dPfAsJ9nHE6TaHWSqQ
	EewCHUN5nPkQ2aoPxUOq+U/6LT43l+wPPYSbcOigGteP0udaEi8oNhPmXaCk+b7NeiG52TN/tuJ
	HCVx7BC0DGlTiDphEEx7wcFCJtl48Xk4AuC1o13iCw==
X-Google-Smtp-Source: AGHT+IFLjB7KQSOezxE3un+wsyvOh9Qgd9u86sGHGn/DUwroXxMx+pGUvqQiarn66ca9WBFZwodc/Q==
X-Received: by 2002:a05:6a00:e1b:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-73e268ee7b6mr4803227b3a.11.1745509812480;
        Thu, 24 Apr 2025 08:50:12 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6b274sm1615473b3a.100.2025.04.24.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:50:11 -0700 (PDT)
Date: Thu, 24 Apr 2025 21:20:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] cpufreq: acpi: Don't enable boost on policy exit
Message-ID: <20250424155009.i2lwvcuwnxo267mj@vireshk-i7>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
 <7ce4ffb166beef83cf1bd703a41bf91622011585.1745315548.git.viresh.kumar@linaro.org>
 <CAJZ5v0iCrQeKs=4S-x83Fgf-W4u=2JYLA5VmgKPaLCvYAkNpig@mail.gmail.com>
 <20250424071503.2uhc4k3jxy7x5mo2@vireshk-i7>
 <CAJZ5v0hLBE0vLvpw6k8E7KxiUGqXbH7wEZwFhEziJNYqfxJbyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hLBE0vLvpw6k8E7KxiUGqXbH7wEZwFhEziJNYqfxJbyA@mail.gmail.com>

On 24-04-25, 13:26, Rafael J. Wysocki wrote:
> At the HW level, this is certainly possible.
> 
> Say two (or more) cores are driven by the same VR.  Boost typically
> (always?) requires a separate OPP with a higher voltage and this
> applies to all cores sharing the VR, so if one of them says it doesn't
> want that (which is what the bit in the boost-disable MSR effectively
> means), they all won't get it.

Right.

> They arguably should belong to the same cpufreq policy, but this
> information is often missing from the ACPI tables, sometimes on
> purpose (for instance, the firmware may want to be in charge of the
> frequency coordination between the cores).

Ahh, I see..

> > Also, IIUC this and the boost-enabling at init() only happens for one
> > CPU in a policy, as init() and exit() are only called for the first
> > and last CPU of a policy. So if a policy has multiple CPUs, we aren't
> > touching boost states of other CPUs at init/exit.
> 
> But there may be a policy per CPU.

Right, and I thought they shouldn't interfere with boost of other
CPUs, but above example tells a different story.

> So I'd rather not make this change.
> 
> Evidently, someone made the effort to put in a comment explaining the
> purpose of the code in question, so it looks like they had a reason
> for adding it.

Fair enough.

-- 
viresh

