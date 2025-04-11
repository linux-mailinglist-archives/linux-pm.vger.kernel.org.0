Return-Path: <linux-pm+bounces-25206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2E6A85664
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD374C2F73
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FD6293B73;
	Fri, 11 Apr 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTnvDiDB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F7296142;
	Fri, 11 Apr 2025 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359722; cv=none; b=N392CbzX5zCjDC5W0VKQhNQo1V+N2f95+IAxW1C9fGBqkT+ACaXe1CSbmJrb0OxUEWQCiWnYNaA2i/6Q0h5Cpdsl57MIYDeXZOFQfn4r63JSYQjSpWNjwBlKAPKztf2WZmsEsQGGBT0qpjw0456R6ULSyHXbbtrny2DlQwpreic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359722; c=relaxed/simple;
	bh=TYK0Wf2IsL1LKt6W8g2I+knobB+KB8JlobtmFnUY1eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYx0YBFYkL3uN4g5UGi77rXNJHp7rUsyr+ZprAzyFQPt5UTleLbVi4p+qdSj0VxXif/z4DGZPgGNdIMV9J/ioVfQvekQtu2ZA8BsJY9uXKi0I3t+rT3KtI2BLR3+ilmjseByKA6TDO/gWVBycHu4Pz+DCA++Hv06m1BbF8VbVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTnvDiDB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476af5479feso16759041cf.2;
        Fri, 11 Apr 2025 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744359719; x=1744964519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TYK0Wf2IsL1LKt6W8g2I+knobB+KB8JlobtmFnUY1eE=;
        b=gTnvDiDBtskUrSvCF/Qy+kJE8JJMXJzro8Zq/KavCs7vie+aM7b4VHJN4GitB33f95
         5P5+l0GP4pbWSnY+yA0nG4BD1VpWhYYnfZd3qMRYtyrNxwm2KNDplw2myPIELjN5Ywf0
         RvEkpQiqjuHzPdgtojdiSz8isNqCS3DsiLRgMiqpIWKflG+Kg5AlZ8z5slP/13lQwHpn
         FSUBsIGeM24E/VTQJ0Axs9SYbyFrpxh3Vjy6tLLoEkF90pdkAgfrGmQm57A1G9BqkO77
         oG9jEeUOUWMTzP8nM/V9wnsrYQ6Hz7KeegOgRWGet0tthZU8APAbkZ8qKuEnh8KFS0Db
         kjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744359719; x=1744964519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYK0Wf2IsL1LKt6W8g2I+knobB+KB8JlobtmFnUY1eE=;
        b=Kr6hMUrUeQ7p60qUsZt6M5fYxkWbmH/wXvFyw94+cn0oWg5jYUAu8XzLGZnotL5C+n
         cfWNdNDz1d9MYU7ZVCRUAY3SKRAOXDZ7YuPGeX5qwOmSki2ClfgdtepZ5kaIA874MfPF
         oc1KhHLGK9aRw6Co5lnNG53wXECC2X9qJmaK/pj8gyKzawJKLakEmCCMIgtdXkYpzWPr
         yWaqHcpwptu7SkQRQ2itQzVDoFBQwrtg033y0KE6zBJ0nYjFsJTAVN5vxW4eY0DUizlE
         UI9RugnKukigRu8oX/DIAda83W4YtoNnvS+wokVBWN4H6XUXyqBP5ORlCyD/BbM7RQ7i
         bhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMjg2lXNagUyK9T1oWXnmkn2S2J5jhSb80o5KUM01ljSMRLD4+uqrHURCv67d7wM9ghQSXY2rrbiJE6rY=@vger.kernel.org, AJvYcCW43+P3STxsRjEeq0tc6Ie+RlmhMkHMFMUPiU55rL2pfVqB+JhreDT5Ik/xbxZsxJi/TYnULfj6LGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmzuWt1RMnBiv8rQm19XS9arZimFCIBTa8FBJNhVv/LbKyzoD
	TEcMDeuOX2PJzx7Ml28ioJayw3+yke8Izkz8Do9d8I/YlR8fOXsx1jS2kXMgG+7PXmZsOIJwTrl
	C2gI1Rr96uvsSANSrrq9WNmA9O6hhSqoD
X-Gm-Gg: ASbGncsHXL8HHIm5CbuugdCJPSe5fPcVqBC1TcFfU+ZGabfsnkqoLsGIW9QI9rWcs0D
	7qutnbqwqcQfMm2D9X3cqRmsIcqDpqUHOOTI+Kbzpzcdg1balGyrP4Lfok31l0cS34VjZ2WjneD
	cAX63nlXOq+tvMhHYUjCbtaeg=
X-Google-Smtp-Source: AGHT+IEtKuCH9UnBosO14/ngAFvPxV0CRBDOD2T0Hg1J9ZT3B5F5Oc4UU7uJUaMRqVTEL8CO6+6qB4X6wZMCcTE/cUk=
X-Received: by 2002:a05:622a:44f:b0:476:b4c9:f495 with SMTP id
 d75a77b69052e-479775b886emr26586951cf.35.1744359719314; Fri, 11 Apr 2025
 01:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410024439.20859-1-sultan@kerneltoast.com> <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 11 Apr 2025 16:21:48 +0800
X-Gm-Features: ATxdqUFKut-uH_0aQScHb7EaGHsMdOjhXCoo1oB35HQwlfLoMO68Ox5bJZ6Gr9E
Message-ID: <CAB8ipk-EAALE1bhihF3k8i=uk_cPtDom+dD0KP-U3k=vgVj9ZA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util
 is unchanged
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

...
>
> AFAICS, after this code modification, a limit change may be missed due
> to a possible race with sugov_limits() which cannot happen if
> sg_policy->limits_changed is only cleared when it is set before
> updating sg_policy->need_freq_update.
>
could the following patch prevent the race?

https://lore.kernel.org/all/CAB8ipk_Ayqmh=Ch2aH2c+i-q+qdiQ317VBH1kOHYN=R9dt6LOw@mail.gmail.com/

Thanks!
Regards

