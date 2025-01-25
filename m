Return-Path: <linux-pm+bounces-20946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0701BA1C038
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 02:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F23416C93C
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6051EE01C;
	Sat, 25 Jan 2025 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rlm99Qu0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93D1E9917
	for <linux-pm@vger.kernel.org>; Sat, 25 Jan 2025 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768459; cv=none; b=M1aYz2Smg5QdFRyPyqaahE2uwr963fZIr6+IlXgZfV6tDZeCrXKy1eSmFbM+zXHf8l/+kt8qNfA+HeKgUy7Rv8KUxqpMWPg5UFx4X5nls2m/FcgiucnsFoRwr7cocLF9tkmgAIdI+CBrl9OyJ3jKofmD5wHd0Pzs2GrL2Co59rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768459; c=relaxed/simple;
	bh=kfidSHmbxgOnB9/75Z0Mfl6TO6ZTxDdFedFPlmzMN1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dg3P8MXGvsj+PAbRG8ARv1IzVSaQb9w0hq/ERz5mJPPSqP2d4t+sOV761DUb3/tnF/QJ3l3RGBgfEiDZalSJPnwELFDhR4bCT/CQlEstuJ7ql/wuXYELkoKLIzlZVd5K6aYE3Wdhh99IxUldFoiqYR+dDgmQGqGAwzqKKh0DXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rlm99Qu0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163d9a730aso55853015ad.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 17:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737768458; x=1738373258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfidSHmbxgOnB9/75Z0Mfl6TO6ZTxDdFedFPlmzMN1A=;
        b=Rlm99Qu0NNz9ldED5l2yEfhMrklqZPRwQifUxdAJop1243rmyl5Wyi+MPObUVTE36T
         h7QwpFyD1JsZXtHTJGkZhBGZX++pw4oGv/PGatIueku58S6ZeucxWfT6PYLLOvhhPHN/
         lhgHp4LDDp0KEPW3vSNYf22lRivcwt4WD1tQQtnK6Q5dZ8Ua9/pYSLbUkE60TT1tctDe
         giWDU8ALxgcodFtZhosZR+gG94EJjp6pvTXhT7IenRzXYdiQuH26SwE+nmafsHV5solq
         HuZVO5iE7Xbkys9uPEq4+klnLRPi0Zi7KryckzDbfc9FIKoJHpGSK9vGF2MQybpkVNVE
         76fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768458; x=1738373258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfidSHmbxgOnB9/75Z0Mfl6TO6ZTxDdFedFPlmzMN1A=;
        b=FH8OgKQHTuBLpJSmVU2n9wUdKrsIn7jVY364Zju3kpJCmo/Tm/zuHVRN2neFNBs7CQ
         7IR8X+fPepQY9xxta0UFl0Jh8c1Vz9o7Ukxbek/hEkJj6rIns2J7Tf/nF7GQNDsBfNis
         q+utXgw4wSzLq2ojJGYhAiuZnhCEoiQqYt6HzmLdso+pHEMMHbcjfgk+R6gcQBN/bY/I
         RW+X0y1sx7C9L7dDCqAXhCIpi3X46tlmBsowTiSkPcTnDDcFGJyKhLhio8SlwB6QmKGS
         irmG2IxMHKMZZhHSgkAs7/SD9p3NFklQfwP0igMFdZ7x+Hyu//tE277wNJYfGRnDcb36
         U7lg==
X-Forwarded-Encrypted: i=1; AJvYcCVbRQAAsQVfW/mwjrNIbelQJwwhHaeirepIKS6P+FtKZdM1pZuNAhfdYP+8PDATllxRiyqF3v/8Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzV/FEY/4PZGEyRcu3v1zon2zKGcqOS8wlaJx1gcl2+NEu8ftv
	1QhTco1RkX/v08eTgo0jxKRljMF8WmRGYxEmxqx4e/nudm0+QCQkp5TcIb+md0W2z6uQ1A==
X-Google-Smtp-Source: AGHT+IELBMc7dMnIqFdjDchTOfCLu+kjz8nw9HTDOcVfnUFyGQfVruXBkW3NA4nAGJnNa/aL6nW3ApS2
X-Received: from plfz10.prod.google.com ([2002:a17:902:d54a:b0:21c:2d63:f756])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:181:b0:216:4122:ab3a
 with SMTP id d9443c01a7336-21da4a11b82mr89219405ad.1.1737768457927; Fri, 24
 Jan 2025 17:27:37 -0800 (PST)
Date: Sat, 25 Jan 2025 09:27:34 +0800
In-Reply-To: <20250124152824.292985bf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250124152824.292985bf@gandalf.local.home>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250125012734.1661860-1-keyz@google.com>
Subject: Re: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: rostedt@goodmis.org
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> As for if it should be applied, that's for the maintainers of the subsystem
> that it exists in.

Thank you so much!

