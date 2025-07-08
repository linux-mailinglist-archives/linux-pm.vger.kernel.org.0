Return-Path: <linux-pm+bounces-30381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16CAFCF5C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782061BC5499
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3EA2E0405;
	Tue,  8 Jul 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOBK1fUZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8F2E03FE
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988973; cv=none; b=Zpj6KmGcVlK//21C6ILa6+faVsRlMB2ZLWPgv66oekBpKeH77BDWs7lzzlYr6WG5t7NdcLfqF/rzICo7UwUl3U5PmVaqygXSZ8iV9SPDiUIzeTH3+GwKeny0OD5Rr8gwHcXlMVpi974JWmL1/cmeRq7EBQiagRjd/1M4jALL24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988973; c=relaxed/simple;
	bh=MYoMBKYTdN+8xP9wcucpfxgCMC4X7lR7pJmRicnPgXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTIiJCndYp9lVp+82/QnF9QrE+FU+eva+lXVBg+HVKyXX2/iYw+aM+8ljhGCe5il33mU+PffdDw4I3zqGtZVQc0PIKCSj9w47rDSJeJeO+eKKurPsTtS8Ry+cj8ztqQCvBObHUS4lnsYjCSU5aMQ+df1/L6lAQPKwmson4ZFzD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOBK1fUZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso9757a12.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751988970; x=1752593770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYoMBKYTdN+8xP9wcucpfxgCMC4X7lR7pJmRicnPgXk=;
        b=sOBK1fUZtZ7RwQdr3WSLtxP6b/fVBLUGPYtx+TuUvUr0lRABKoxtJsW/Zq+C+mmtfI
         5SE6XQe3KvlrKRJ9K3po7J/0sz6HE4ol6lAz/IRUjp/GNWZgNT5Dk4oNYe3cQNnJ3JVK
         cdnf0KanBRwcaoak4OP2zCR6GQxFikVktkH+Es3rLZdSSjSGfFygnOBDttEiuljv+BNU
         eAVw4l1DfokRSvrIQNP3uKPKEodVOboGhMfHaiU0VtbrFUQVK7S4A5z0usMEfnoN2Oay
         WICfh7PeXVsujWuawFJtO9mqX9yTaFVHjpknZSzL9IiREGN0ByYdpp1EFJtBWP5h1uC1
         /y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988970; x=1752593770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYoMBKYTdN+8xP9wcucpfxgCMC4X7lR7pJmRicnPgXk=;
        b=hyaf4TJ1phQatCWrCkKL+MZ5XMeZRYScBKqCAD15mo/6SYOZSn/waOatcquoNvas/a
         D3Qt64+w6AKI6SlTKpmYsG4o/NfZZcb7i640Qsnsz/69E36Obr0pkG8xmc+pGv2VbPsg
         G4xeKtzhapbz8ZeHj9VZiglTxz1Yc90QBsCwyjwIGrWDfrs7cNRvk0qyjCuAlgRXA+AP
         xMEF3BMTuU/lfoeWoaXrcu0L7Wz650fhnZ4Y9yIGQD5Dr4O1ti1m2GvSfgENR/wuC5Mq
         lxRPW9ZTqZi+fF6kNoVllaBe6+WicwjmT2YuSlzMwHGkaGRNLMO3dUnOF7t6/McTpL7L
         vN4w==
X-Forwarded-Encrypted: i=1; AJvYcCVfYuZ5YZvm17J3Dxgl5Fmpgy2URj/y/YCnCoKuMP+hEHE5RcLd0nfrxIwFreiKz/xeo3MNatoqAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WCaQgIFtCem/h6LTRQmdoQQv89pPZ3IHIPhmRBjPtwJ5byVa
	w50P9u5rt1QlYHhubcUqcCLs96Jn+SoV4P4F/PkPcAUvaijlZJWyIcOn9o5jobzWfVTQJ8uIUfh
	clwg5w4xb1vRs1gnU32DBxg0dzkscOODD/3M7QyG2
X-Gm-Gg: ASbGncugvmE5TAHATk3vSKhS5W2R90J7bz1nrKC3TYJRejKW3yWIG80573lU6rMx5sf
	UEGAmzhcdXZBoPDS0kK8z+ANKzYrVHECI3mcmt6XQNh/ubIe/zuSy9n5NJRGj6t6K0s7zX/jVcn
	G0htv+2oUmmYf86oTa0MOBgIqxiXVaEHjVAn1jrgHcxfVimF57YAHr4uDRyA+TJkkD0h7/EH1H5
	w==
X-Google-Smtp-Source: AGHT+IEPUK/jvl04L0OyeFsSxIjRQtkdBjuLNluT3iIs8drQXWQ//HPwuIFPYk1LRglja7VeVEMSrWu7C3Y4sbePbGs=
X-Received: by 2002:a05:6402:2142:b0:607:bd2:4757 with SMTP id
 4fb4d7f45d1cf-61051c1dbd1mr69264a12.1.1751988970231; Tue, 08 Jul 2025
 08:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com> <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
 <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
 <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com> <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>
 <20250707101019.GE1613200@noisy.programming.kicks-ass.net>
 <c63a1698-2d93-4105-8641-ecec69b48523@huaweicloud.com> <20250708072852.GD1613376@noisy.programming.kicks-ass.net>
In-Reply-To: <20250708072852.GD1613376@noisy.programming.kicks-ass.net>
From: Tim Van Patten <timvp@google.com>
Date: Tue, 8 Jul 2025 09:35:58 -0600
X-Gm-Features: Ac12FXyfsRKbqGkPeoIgIohRRLgHBPdWpZRSJXL2Iv-TPWxxyVYMGYfsAif89Ao
Message-ID: <CANkg5ezUe4--TyR5rTrr0LSeOcEAtnDaydGOmxQq5nvfeEpwwg@mail.gmail.com>
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being frozen
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, "Michal Koutn??" <mkoutny@suse.com>, rafael@kernel.org, 
	pavel@kernel.org, tj@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Content-Type: text/plain; charset="UTF-8"

I am (admittedly) more of a naive observer here than anything, and far
from an expert, but my
understanding matches what the code says:

* freezing(): Check if there is a request to freeze a process
* frozen(): Check if a process has been frozen

> Before this change, most callers of
> freezing(p) would receive true when the cgroup was frozen, whereas now they receive false.
>
> My concern is that the state where freezing(p) returns true (i.e., the cgroup is freezing but not
> yet frozen) should be transient. I'm not entirely sure whether all callers of freezing(p) (except
> __thaw_task) expect or handle this state correctly. Do the callers want the intermediate freezing
> state? I am not sure...

I agree that there's not a clear way to be certain what the caller's
intent was, so all we have is the code.
Based on that, my interpretation is that anyone calling freezing() is
interested in the transient state (there
was a request, but it hasn't completed yet) and any callers treating
freezing() as frozen() are incorrect.
They should be calling frozen() instead (or possibly also) based on
the documentation and naming.

> Given this, I'm considering whether we should revert commit cff5f49d433f, provided we can safely
> remove the WARN_ON_ONCE(freezing(p)) check in __thaw_task. I'd appreciate your thoughts on this
> approach.

At the end of the day my goal was to clean up the warning since it was
breaking tests, so if we remove that
as part of the revert then we're still in the same state. I disagree
that we should revert though, since the
code now matches the documentation and naming, in my opinion. However,
I'll have to defer to the experts
for the final decision, since they're ultimately responsible for any
changes here.

