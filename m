Return-Path: <linux-pm+bounces-38266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25682C7233D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 05:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2FB4D2904A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A418A1E9905;
	Thu, 20 Nov 2025 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hqc7BOZo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0A2AEF5
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763613949; cv=none; b=JPwPM91tA1AIkqE/9b3TJHpVcQxMVuKjFbuQ+Pa4qlogRrGtbNnc8vxbMok61MF7LknztueZ5VZGL7/hb22ybAhrNceu8yu7+CrNbNE9D3E7tvuBe39az19eX522P4nyGePaWvkgjfyHGLXWByzUCIyWQdMqDIZ/IgkoOZxJzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763613949; c=relaxed/simple;
	bh=tNuAGLHpwPqBv4x5RWVvU4mnerMM3wfngMRCI9Z51GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V/4aUbg2J427dUdW5RlLXUqhswQVytLzk2SmhxER/iJUBkYt+alRIvSKRiTXn+wzu7hacx+cmvzdNTERmDgcmWLsMUZoA2n1xIIA555HjUPtktY/ZZne2M2BxEXIoRSjR4IkOg6q8QI1+pKzFbws80yVZVlbeRSENAqZxxU3kDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hqc7BOZo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so264915a91.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 20:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763613947; x=1764218747; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4csVDGQi0uzI7KXFvmFTROpehQUVFhpuyhu7CkMbL2U=;
        b=hqc7BOZoR6V+7CO1u5NWDvPCVnQfd4/wwfT7h0d/dGCesCzZKwQRf/I2v1e+mPK0H+
         XLzwETf1o6alU6AH2vcHy/95oWf28HniV+oxooLC+4QdjPxDSqFLsfFm/i/jXVmcjkON
         4SGQqHH+38MYhodFCHSZj0OIvMaDkxrnN0kmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763613947; x=1764218747;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4csVDGQi0uzI7KXFvmFTROpehQUVFhpuyhu7CkMbL2U=;
        b=ouAPThUc4mw/f8pc3JS9xcVg6Mxr7YFichfRtevlZsbm+CXT9qFbqhi9yazOg8/gp1
         LoXlDuILEBEWGZnsirKuSzYgOiQoUZYFHrxpmkUOB0kn3Wm2lF3uwa96NFyIry3QfeN3
         gDMT0UFZmNVNw7n4ePgKdiMJunn1d4A45ZPnABf2Mfb+XVEny/X+ui1oVAoPgYDES8sp
         99vgoC8567rAtHEPLb9jzx1e5U+uRxKAhUmOlc3nvgBJA5QYagkfjTrGbt2eVNTjp0Jp
         0VRxOzbmXNkBaXM0HK69o092BJuuS6M6u7MTlI02zdpevEIAUAciQnrK9ZtaY30AkCKI
         ibgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrneXmDKg15Hl51vKAp6E/IODiVgCzzsx8+rZMl3/Ej/AhNIp2cCVJ/sHNcRwUHoJ+HuGJxnwpcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FdTKdsbP9xa5Kdq8nToiA14s/oYI28qMD5HGRSrFnxvtdCsE
	kbUmXOHnclyKdYUjOCZekcsBMI4Asly4t45slff0bs4MlqNgZIzOyPsF1NHdAOpD7w==
X-Gm-Gg: ASbGncscrmvw8fF30muNAuvhlJDOSNwvnK0oGNr35WQxMe1OxpEU9n7TBZyipdilFQr
	ciD64wxkK0zExTQ4LCZ1oYUx12blD8/08Ka4vFEYxXuiEKSNu8LGzSGgyn1B3J4RXH97IxCQ1X0
	1Y60LMBFTW09WJmRm8QHJkLOYdQbpRb4HI1tHke4r5Tb3jF0oJlWpLSx5tagIQDBINByriG6rwy
	BvEwbJf9wFm0wJmll06Aq4HaC5F8731QSpw+//L+e55XOp6BtqPMz9k6Y4iNqrIXaIluyfxcHW2
	Am2SI1Zsg/+8E5e62OACgEeUJy8GFwxkIicQyLO+R5sNQhzXsxdb+RKO5qV85sbQcUKKb3qsIna
	U7n+3Grm4i/m3QPMqNCxew5+fgKY5yomVlehP1//u9+844kkdXu+r+m3WtX3IH/jFnDKQjBjSkR
	4zj/yc45Kjv7+W8rE=
X-Google-Smtp-Source: AGHT+IE83S5WPqoVOxTlsmYoJYXn0pYm7LRkbtzXmy2+9sXRVSXiPydiB5UD2ENbkUfqj+ICV8VfDQ==
X-Received: by 2002:a17:90b:2f44:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-34727bdb84fmr1856728a91.10.1763613947454;
        Wed, 19 Nov 2025 20:45:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b04f3b8dsm2908936a91.12.2025.11.19.20.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 20:45:47 -0800 (PST)
Date: Thu, 20 Nov 2025 13:45:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vincent Guittot <vincent.guittot@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yu-Che Cheng <giver@google.com>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
Message-ID: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We are observing a performance regression on one of our arm64 boards.
We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
Rework schedutil governor performance estimation").

UI speedometer benchmark:
w/commit:	395  +/-38
w/o commit:	439  +/-14

