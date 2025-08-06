Return-Path: <linux-pm+bounces-31979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F0B1BE17
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 03:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777AA18A31EA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 01:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1628C433AD;
	Wed,  6 Aug 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="barlQ94n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39D18024
	for <linux-pm@vger.kernel.org>; Wed,  6 Aug 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442025; cv=none; b=gDzlRfZuPQP1p+S169HicimbomfYxE9zvWmYDDaDsPyFJ8KtTQBitr1wtx78cHbk0lmRkz6QWe4zergm5UooIQeBiXpHDgTt1wMRjmq74N8mYwE8jiCQSshUbunPR67PhxyKoZ6IDmdAbpAy/HKcVVe0HaVYuUc7nAKrHBa0/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442025; c=relaxed/simple;
	bh=p1mRerMEHgeNuo8Gmi2HzaVtdWrvQbrDxXm8DmzOiqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4mibwRoQmr4I3YE4ZijDfbqyuZmKBfsuaqpSueCX9p7TZss6d84SltzcQR8AB82z0UKsgmBcevGZR3RoysyJYmOYqfbFwIFr06jeTWVvtbfuDJTbVALCemBm1wxEikorwJpj/hUhEFgrvp3k2XrB2yjjAx+aDV8dEwV54W8hEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=barlQ94n; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4aef56cea5bso40081cf.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Aug 2025 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754442022; x=1755046822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bX8EsWN8G5GL6UrgORFQI2HBOvhhV7DfKPKAupHsb3k=;
        b=barlQ94nlrlmRHjnzAYTLjyJxMyAxMMrwVtitk03aFbBIQ1d/bK8DkfrWcG8H2svXq
         iK1Ptu7AEoFbkoH6UCU5qj9RafRw7Ixgr7SS2Wb5tHdRio8fcv3Y5ju7kuF8xvTH/uDo
         cK265zWIDv5qL25opBciHCkjaTUi+VHOPI3BV808jAEA046Ur+UB362NAKSxRFLwt6p8
         SiYpIJrRYCbIYUnfNdyNapex752z/vinto8KJ/hqD2NkDJmOgAnl6D4pKXerLlMfXDJu
         NnEwW9zJDdRT3S/gFIjssCk98Uh8KyWDnOzL3fQkZ6z7xQ51Bf4fvwF+RQhjPC1alxsw
         Dtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754442022; x=1755046822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX8EsWN8G5GL6UrgORFQI2HBOvhhV7DfKPKAupHsb3k=;
        b=MZrq1ABmAxju7SI2uLrkwFPBIQTIN371cQ3vKDbjMyFydv5HdXcS22n4G+vYbYW7ra
         LlnssJv89LfaVxJZNwIclrYN43XRGQeJ382aSvLJevI/TDgN5+C1J22NvFM3zdolPmCo
         3FXZRYTNBAV8aLS26MFMt87kCAHvFAgD7MqPA3fVY108klLB9+7fgfiVuRMw/me6bLrY
         JpfAN/nD2okWdzKchq7cSY/16cnZkuWiV8+c2168VY6krkrgsUhefW5qP1v+hjESKOpS
         97virrHlSwlKyBP6cILz9ARmfAtxpOqW/oDA9z2rZuFqmVS/HxTqKSj1IQnGkGR22DQ1
         Pdpw==
X-Forwarded-Encrypted: i=1; AJvYcCWx5e26iVlediS8nDuxLcu2j2j1A4x4rBnu1fAUa6idpSbXl4uovK5KHeBZE6oHaJV0j4o0x9BC5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7VmQMtzcxUV1EJIhl3s/Gzguc6CLj8WRDFgl7Q9xAgLfE8eS
	QzvUMb/nQF1hWC8fOlDmlRytbdXcISWlP/tHuXZmzmkX6WEsTS3O0SJb9SjAmBeEtwvPZleZ1Wt
	ziJMQL0mxTVA27Ny/i7rqmPdCAZfG1iUE0HjryrVdTLhVqo48vRGUDGIvjzw=
X-Gm-Gg: ASbGncsdhNiaC+e9gClrECHc0VJocg4+JNhHSViLr0K0ItOtX0jFTwRzWoRxreS2sSA
	JId61SdbEjxP+VKamskPT5DwxgDlKdneet2dlNOa3dQclxKvB3GLWGPeog7WnwoxdjI/o+yrCTc
	9T1V/qFpsuo36kShnBpTUG/YbZkDaF6VN8tDtb2B9tXQ/oprToCQ+apOmmP2gEI4UFW5DQMwUxB
	H/eeg==
X-Google-Smtp-Source: AGHT+IEYZXFlvLRTmvPHs3BhJmh1UNSqPuk5tHmGvJQ6E4hzMgUc2DFs9BUi1j7G902TGr1aF4a8qL7YBJk9bs+bEQs=
X-Received: by 2002:a05:622a:10a:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4b09261a067mr1532851cf.3.1754442022008; Tue, 05 Aug 2025
 18:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730220812.53098-1-pmalani@google.com> <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
In-Reply-To: <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
From: Prashant Malani <pmalani@google.com>
Date: Tue, 5 Aug 2025 18:00:09 -0700
X-Gm-Features: Ac12FXxCfIuM-Yd1FZB6zRpfVYWwqRzEGG2J-R3Y7u-oTDt1TL5FFE9U-zeRXnQ
Message-ID: <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
To: Yang Shi <yang@os.amperecomputing.com>
Cc: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, beata.michalska@arm.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

Thanks Yang,

On Tue, 5 Aug 2025 at 17:26, Yang Shi <yang@os.amperecomputing.com> wrote:
> Thank you for cc'ing me the patch. I posted the similar patch ago and
> had some discussion on the mailing list. Then someone else from ARM
> pursued a different way to solve it. But I didn't follow very closely.
> If I remember correctly, a new sysfs interface, called cpuinfo_avg_freq
> was added. It should be the preferred way to get cpu frequency. Please
> see
> https://github.com/torvalds/linux/commit/fbb4a4759b541d09ebb8e391d5fa7f9a5a0cad61.
>
> Added Beata Michalska in the loop too, who is the author of the patch.
> Please feel free to correct me, if I'm wrong.

Thanks for the additional context. Yeah, the issue is that :
- The new sysfs node is sampling period is too long (20ms) [1]
That makes it problematic for userspace use cases, so we need something
which takes less time.
- The central accuracy issue behind cpuinfo_cur_freq still needs to be handled.

[1] https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/kernel/topology.c#L283


-- 
-Prashant

