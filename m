Return-Path: <linux-pm+bounces-27727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB56AC6891
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 13:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257E94E013D
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F022836BD;
	Wed, 28 May 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oiarlWmS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511D1DE3CA
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748432684; cv=none; b=Ql6Wk+35RvXKnpESorU7ztsGq3J4Ic9PPGEq3dAyavi1EbiaUuLEt7pzxZXI4xCNPnrvl3p0XXYR5L6EFNAFpch7pnOGdlvgRLZ3wZCooWvBZbaJ8dS/aQzEsZjn65YtAYSMC/0wVW5yPvwah4vSysDE2+z/ij7Av/WkPtNtA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748432684; c=relaxed/simple;
	bh=5w3iOt7bx4YXe3uuZGSNrtCQB20LCWbDNaBLbSF/puo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uEt+PPi2qO9LsqPgr8brprTldRLoZcFYbVYtakXfKtDGsUbVYv6aw55QbRfe2FlUSUrTxe6B16XJXGi4A5uu/1z1k9wPh8cJdFv+lEU4lqOFEe8P/Ys8O9CUurUMPOzNFR13B/YL1OEdhW9phERyiQ4VN3oh+iyGvC+msZYGgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oiarlWmS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-441c122fa56so21422705e9.2
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 04:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748432681; x=1749037481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YESEUHNULXjnKu632GnMNSEi7CRefD1s+NpQnb/WNfg=;
        b=oiarlWmSNnqq+ZKXlXCDsK89LbLyI8oI58y2Vm+ihgkKnVCdwGxJ6NRFX2tW3oImp/
         PBb+oBejls+8o1Erguti5kRYaZi1t/xYGV+UqW9qxQwwWGlhGjHUUw8y6zhc3jzhinuA
         eaH6DXQ64MVIZo1jyPSfEBcohDnZJsARt806yenyUFSeTEsmoEdKye8fvOkVOLlz4/xI
         qV9ZpUAtfSVMdEsC43yEeoc7P9pw5W3bmaTdgaF+lzdPKb2mW/Mc26VkcJuG43T8n5Aa
         +NiC0sYVBh0SZXrvd0j6AityOsZedslhxCOLZDSZYNnYowYGwQPr30th3MK2l8OLYsQF
         3cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748432681; x=1749037481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YESEUHNULXjnKu632GnMNSEi7CRefD1s+NpQnb/WNfg=;
        b=D6K1Xs4FQMXYPEqKBAb33KUl0iwffYC3Lv5YW6ku/gIY6ZJyXsZLLLMde9M/j25ewh
         C5ve2b2NatOFuo7uaSo8e87dva9IJncMp3m63/Mx8Hll5HDAHlaTRQyPAgIoYH+wyf6R
         FijIABJI2WdWcTAf+QJJPBZEHGT21C7zFQma1CDJDdOr9ooj5Iag2CwvYkD+iywvJeL6
         VgEGS4ViHEX1y0FR9obbW6q5JWl0T1mvNz0X/PpvEiO8xZ+XNr2D8lF33UyoUmExfZTt
         3B3D8PtB65ZmyXiuPLx7KVEEPBhQwsBjNFepfj10pAI4b/ZorvOwQi0I3D0HcQaYmsNL
         r7pA==
X-Forwarded-Encrypted: i=1; AJvYcCX7iHJR4Mv5a3ZJkiD6+AcMs1B0nHWZJb0WSQ5brL911XEQkPisrzj3aJ/LTu9GhT/djWkhIoZESQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZ6XFTLWDUGcxQd6msFwMUpnjQLv8BJe1/BixTvk1S8/dpm9j
	wrZ1/Yk0S8w4yQky962+XQcKMaeNdFANjMC6RBSm4GpEYC1Nd+1PW1fi1LfwP/ViIKyVo6a7H8U
	ZpGASRl1khRGK3VOMKw==
X-Google-Smtp-Source: AGHT+IFrdANS9CV9/9pHZOtJqQeMGzp4ixqVl0yKawCo3pc59IGgF9aalERcu0cITtJClcGXKVU9Vs70mqonTYc=
X-Received: from wmbjg14.prod.google.com ([2002:a05:600c:a00e:b0:450:cb9b:38ad])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:13d3:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-4506b55d111mr12634255e9.6.1748432681772;
 Wed, 28 May 2025 04:44:41 -0700 (PDT)
Date: Wed, 28 May 2025 11:44:39 +0000
In-Reply-To: <CAJZ5v0iNwBhpmkwuo7Z_dGmLE5KQGONNRrt5kykXXKRoORTShA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250520061944.pl3mqw2clo2roe3s@vireshk-i7> <CAJZ5v0gBRQ87bFk3-MCOudgvGWb29O_ihfz0Lo2kGcVpfSu=nQ@mail.gmail.com>
 <CAJZ5v0iNwBhpmkwuo7Z_dGmLE5KQGONNRrt5kykXXKRoORTShA@mail.gmail.com>
Message-ID: <aDb3JzdsrrLAxPlW@google.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.16
From: Alice Ryhl <aliceryhl@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, May 28, 2025 at 01:35:35PM +0200, Rafael J. Wysocki wrote:
> Two merge conflicts between this material and the mainline have
> emerged since v6.15.
> 
> I've resolved them (they appear to be straightforward to me), but I
> would appreciate double checking the most recent pm-cpufreq merge into
> linux-next:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=25eb7dda15f182b7355488a5aca47078643633dc
> 
> and letting me know if it looks good.
> 
> Thanks!

Usually we keep them sorted:

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 88ab11d74fc7..2c917889d9ba 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,8 +10,8 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
-#include <linux/configfs.h>
 #include <linux/clk.h>
+#include <linux/configfs.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6eb61c87b616..3a618f82fb02 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,9 +42,9 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod clk;
 #[cfg(CONFIG_CONFIGFS_FS)]
 pub mod configfs;
-pub mod clk;
 pub mod cpu;
 #[cfg(CONFIG_CPU_FREQ)]
 pub mod cpufreq;

Otherwise LGTM.

Alice

