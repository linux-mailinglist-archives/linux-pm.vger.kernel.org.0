Return-Path: <linux-pm+bounces-21217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF6A24D99
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 11:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1453A27F2
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15461D63D9;
	Sun,  2 Feb 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="060c/uhO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376D1D6188
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738492937; cv=none; b=QULpjHOZqmPRRd7k5eUXr0iPTx2lG4DdnDWAL6WLM0Oeo++DsHT6GadTRntfwoMYfsZfcryhvkpqACdFHL1v2OLi15UuF0OSM2CeyJ1TxJZCJKJPKALiWQEp/BEmXg9eZvIc27gFvaiDidDO2N2Hfy8mGraWakACwgBFxrl/jzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738492937; c=relaxed/simple;
	bh=zkD5IRGZ/9bPr0CC0yAMX9lXRbXYUMweItegShby6uE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uV91ocHHBKNC677ezXmGdGswJc6kP353esyfDqFl4760w8vHVee+21cd/OyLjWhuXg1Iqq9Rhi98Wn8CnQZS3y4vnpZMig4ejP42D+NCNpScdpOU31zQNEEJuXWDZ1OjHnz09/K0UIBaikaWZ599+6vpWumu6Jw10foSD2gWxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=060c/uhO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163c2f32fdso109465605ad.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Feb 2025 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738492935; x=1739097735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkD5IRGZ/9bPr0CC0yAMX9lXRbXYUMweItegShby6uE=;
        b=060c/uhOWQe5m+YBtjrrvTg0GvS+5T80wFg8GPivsatUuNX7aAIdNafhJCWiC/kscN
         vqVaPOpfL7MXIvENQAUJvuRNPAVsbd7Xc6Z+ENDWvp7UHWBfBjv8xrHagxlOAkezhZg7
         XnAvXsabg8X3ewkqn0TiQggo7Z4711bbegY46M99RIleWnbuWNGvGfbPgZGMBi6/2fhy
         004zWP6X4PeBFUL0eM0k7yhadAnzhKg6TwzvPoKIZE9fThnjJIzQF4c4NHLiRC4wkOOE
         OAp3Ms+vAYj0Xgr55mwrVMYDPol9m9uF17KPjlB0D3fT2og8anadDC2nwro0Kg2AhM1a
         x3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738492935; x=1739097735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkD5IRGZ/9bPr0CC0yAMX9lXRbXYUMweItegShby6uE=;
        b=vpaJ8llMeymnRw6xBjQFdq6dER016Iqv/XN0iahuBlO+psGTaMPQ2zZ1OwzPHOkswo
         4h7bd/P6qziKveSUQuuiNDT9V7LgCosZa6s2MvBo0aNiBnxSebtBLTGTyQuiah+MznaC
         WKTBte7Qxw4COLrVT2Jcta0LPTJI9PzvhQxWFP3uiQANWgzAKBd4IvrMY1mFb+FIbNEI
         wWE8x8lmlRw/z1YGI6sdYYfQ0kXR7tZuk5XWx0srm6/UolhX8fGLABeCXVHePJGb+MIo
         kDBGdtOMihNewlrO3lcOlEMEd90ugiD1q4qvExTUrSg6cBvWWiO7HdHMqCIAigIgvmUa
         9nQw==
X-Forwarded-Encrypted: i=1; AJvYcCUDboNjHDEIHX/nYpGJCBWFXunHPhB48C3DuM/L8qh7j74QCgih/wJMb3WmcRH59u/w8+jAU8eK8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vwZldJwgLRe2Etb9YXZ/h03VuW2TyaLcaInuJKmD0cqAW8Ng
	K2Y5+0yvmhb6MOBBqYN8z6SaSJVzWzIeY9+Pi5Uh80DQ/mJCfhzrehs6jN4kRiLYcjChuQ==
X-Google-Smtp-Source: AGHT+IFo+c59bClMb3w3IGnlN130wN7y6oOR1HcCzkELMUY8CVZ2GcCuOdp4NbrOfZUYhOCT0CSDVHhP
X-Received: from pgtq4.prod.google.com ([2002:a65:6844:0:b0:a87:a3b9:db3d])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c941:b0:216:25a2:2ebe
 with SMTP id d9443c01a7336-21dd7c65844mr278809895ad.19.1738492935252; Sun, 02
 Feb 2025 02:42:15 -0800 (PST)
Date: Sun,  2 Feb 2025 18:42:11 +0800
In-Reply-To: <7hy0ysi4pf.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <7hy0ysi4pf.fsf@baylibre.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250202104211.2764016-1-keyz@google.com>
Subject: Re: [PATCH v3] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: khilman@kernel.org
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	rostedt@goodmis.org, sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> Tested-by: Kevin Hilman <khilman@baylibre.com>
>
> I've been using some local trace_printk() to do exactly this, so I fully
> support having some official tracepoints here.
>
> For my local hacks, I was trackin the state index as well as the state
> value since for quick debug, I find the index to more human readable
> than the state value, which I have to compare with the
> arm,psci-suspend-pararm from the DT.
>
> Anyways, thanks for submitting this!
>
> Kevin

Thank you so much for the endorsement.
Showing the index sounds like a good idea, although it should be done in a
different layer (probably in the GenPD governor or cpuidle-psci driver?) because
idx here should be the different index from the one we're looking for.
I will keep my patch as it is just for now. Thank you for the idea!

