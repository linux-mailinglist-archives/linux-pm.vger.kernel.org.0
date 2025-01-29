Return-Path: <linux-pm+bounces-21082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8505A21969
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 09:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9273A288C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 08:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923921990D9;
	Wed, 29 Jan 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4b42LYYs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181D1A2380
	for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140668; cv=none; b=VgQGSfVnRc+QDaUwMYOoiSk4YpEvN2eOaDbpO7/XEKhvm0ykB+hVErrZLfkRKhmmzEe132HElCP2f6eGKD4bmYnxX9zhuIAIJQ/lTxT3Tw9ddRViWI2gKxQFdye8JJfFavgxGdi/0RkVGr73+X9MlP7iGnH2zXmuyKmTeUfhp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140668; c=relaxed/simple;
	bh=EbK8CG3zwHwysZnvAo3A2+mZ2myHIVEiysKYTIFeDEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eQ3ace572WkU7+KPLHCH+iKqeCXAf+KBVCOTgMUg2vZq8lIB/obJi9R3mR9YPIkXNxDnoEcNJ99rWOjDzYSUyZKDe1rVm4hALsfbI/tUDJOnBTQ50eTYjwHD4BRG7qt0Jv1HyU0Fc9ysw2ho1ELF5iywpw9Hug3+mL0W4EP2ZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4b42LYYs; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2a983c18244so4944514fac.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2025 00:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738140666; x=1738745466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbK8CG3zwHwysZnvAo3A2+mZ2myHIVEiysKYTIFeDEM=;
        b=4b42LYYsEVMfzv+2DTojEFqbIeRiRxQCi6GRmIkehbtUqlvh7In/5BH1wCXnvdPARz
         sXmZG3cpAUXEUjeBLMZE03u1gJKmJ/3ZJi1l7vK4xky8aYxTc0WT4vAWdRbM6lmO8Q2i
         INP1lSebLwIKm1v/W1rxhRJEGD05TZPota5cW4kB8LVgriKEbKxjtL0czYnBxEG7YPl3
         0CwPKKWXgbq4BtWorh4HQKkQxgOmdDND3Mb6wf9RJT+lndG3j+QPaiF9SQN/6wgQW0n3
         vh7I+g7Ky+J8DMJGGSar2PNe64ivT8ap7boymI1hXpuDBBQsSnOSaOQ8PNFeDsDuO31s
         XHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738140666; x=1738745466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbK8CG3zwHwysZnvAo3A2+mZ2myHIVEiysKYTIFeDEM=;
        b=o/zfHt4vZtS6OoxKtQAppOqYEvdXkB3lezLCdOX3BoOYnYys4n9AJ1O7hQU+IBXRxV
         X0FoZAMxNgTpNgt/1/MW/cs86WH2RCspLcowMbvq8X1f4gNr9tpg9iSOHffUiluPFo7X
         7mCFHXfqRW5MsS0fODTBSu15qMGnCu5iBaNowpdwrSQ3wKMM9TX4UX/cM26zOFwdqASb
         Dwk2PAr0eRb5kpOewfj7ukQn0jL76x5c1xkNR0vQ5x1LBlegRUrLeRKeXWjwGE4CUwxm
         Jm+Yo39jRdKA7FgTqFB9uVwcw7OFeSKVk+SfoJaLQi6301QtDK+BFjyHG9pbU4TBMQPG
         h8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr4eghzdF3W53Akn8GYBU9lUIi8Uk16QdPrUr7TA/1E4tNEZYk2Pt3L0/2+GBnU7Vt4tTJB+ShvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeni6zFnAHr5m2d/060mmAQTuGrZn2KUj0wSiiAwOfttNofo7
	4BCCtkXYA4qe9Xxe8hD1GbHVHnGFfXloeM7bBZ6MzKAsaU0SispSBtTGfk39c+zd824+sQ==
X-Google-Smtp-Source: AGHT+IFYeVGRIDbBJSoDxW1qLEQa6txtsI65vSSYVM7r1a1CEXTC692rDv36eVRGCThjx3Uetdze5Vm2
X-Received: from oabpp13.prod.google.com ([2002:a05:6870:9d0d:b0:297:19ee:9d16])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:5cc:b0:2a7:d345:c0bb
 with SMTP id 586e51a60fabf-2b32f261922mr1412517fac.27.1738140666051; Wed, 29
 Jan 2025 00:51:06 -0800 (PST)
Date: Wed, 29 Jan 2025 16:51:02 +0800
In-Reply-To: <f697970e-3796-41cb-9904-d61cbedec428@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <f697970e-3796-41cb-9904-d61cbedec428@arm.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129085102.1055165-1-keyz@google.com>
Subject: Re: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: christian.loehle@arm.com
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	rostedt@goodmis.org, sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> > Yes, psci_domain_idle_(enter|exit) are not meant to replace cpu_idle nor a
> > variant of it. It's new and different events that provide finer=grained info.

> I mentioned it because it means it doesn't benefit from cpu_idle tooling
> directly, which is slightly odd, but fine with me.

I might not fully understand your comments.
Do you mean that even mentioning cpu_idle in the commit message does not feel
right to you, or utilizing cpu_idle by exposing the determined state instead of
adding new trace events is the right direction?

