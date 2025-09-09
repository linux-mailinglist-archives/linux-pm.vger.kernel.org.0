Return-Path: <linux-pm+bounces-34187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B4FB49DEE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 02:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990EE188B1A3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA2E1A5BBC;
	Tue,  9 Sep 2025 00:19:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC5176FB1;
	Tue,  9 Sep 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377186; cv=none; b=p1OF6dsTn55Qk5N74jS4WJt8UJ667SlktlOJsfMKwKhdE2OkGL1e3HFMp3/hQWTRCQVbtW0HlM31TA6z6LgSxqk3/onm13nOLt3+gfVin9Fdp2q1lGA5UScvFMdZGkAxKf+eRRSrIriprAej7XjSal8wYWewrjfIIICJIRLcUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377186; c=relaxed/simple;
	bh=4r0NsQhLsfOxiKR1RoAZClT3fpMFPT6rmz4K6eDA9jY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O6V7T+w5gakLElNGKFD58+j5U1AH8SzZoYhG41+NvNFKLROI19hzICqL2fudefPiK0ofAHFlpirEJZtj/1IV+zlCrRB1Ms9FwQm8D3r/y620uJkc1VE8Pe0dWLrO5qB8hcDYUxUszOH81454K/AuE8gN3LJ8fISfQttfW33kVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3B8C4CEF7;
	Tue,  9 Sep 2025 00:19:46 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3FEBC180B18; Tue, 09 Sep 2025 02:19:44 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Sebastian Reichel <sre@kernel.org>
In-Reply-To: <20250905090641.106297-1-marco.crivellari@suse.com>
References: <20250905090641.106297-1-marco.crivellari@suse.com>
Subject: Re: [PATCH 0/2] power: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
Message-Id: <175737718425.13878.11571194583527518524.b4-ty@collabora.com>
Date: Tue, 09 Sep 2025 02:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 05 Sep 2025 11:06:39 +0200, Marco Crivellari wrote:
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> [...]

Applied, thanks!

[1/2] power: supply: replace use of system_wq with system_percpu_wq
      commit: c4a7748b551e5a06fe9a3862001192b1b5cfe195
[2/2] power: supply: WQ_PERCPU added to alloc_workqueue users
      commit: cc2ec444e461b6ca2bc73cd7cbd06aaf15bdfa1a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


