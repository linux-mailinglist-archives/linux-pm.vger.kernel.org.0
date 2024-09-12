Return-Path: <linux-pm+bounces-14119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC48977493
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 00:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09A92821AF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30E1C2DB2;
	Thu, 12 Sep 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaOYOryR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1719F41A;
	Thu, 12 Sep 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181745; cv=none; b=bB1gJMq3nMc51rI+R0Vc0YDwpDGUhKykDAGB0w67NmzIxmTW5VVCIMhlT196y3RzKvdoeA/p1CcRszNu1vm1J2roXjv66MzBcQayu32A5Tigjz9wx/MZWBM3ne37rjS1NiyhzJDKANEZx7pMpTGfZApprbH0w/HE/Uy5pm4OlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181745; c=relaxed/simple;
	bh=1fAqIZkQ3lBFl80DRTe5melKKG+bWX3d1ek7rpniYAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHLlsNiHuncAmPD/V5p7jZQwj9YHqsan2W2P74eaK4M2kZ1as8meOdWRLGV/gX/0RUwnT2krKpyFiQTCl240geXmf4f9foKgKAkMWncvYuHoW1URUjP0rzmoRd/FB1MNe82QgdkdV7gOE1W0Ob4FoJZSe34ZOwRksLByEeCmZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaOYOryR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2059204f448so14522505ad.0;
        Thu, 12 Sep 2024 15:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726181744; x=1726786544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWuMZXE9BAfG5V2S6lvMwMxoSKtMEwZr/chmLcyZA3Y=;
        b=XaOYOryRrTsFUCk9nQHhTIYuBfAIws0QwyvBNHXCWk1B8tEREFhg/Jd716Z2amyjFA
         HuZ35CNOzn3HGwKn5TU9fCw143IVh/kAP5jHf6/696G/ZV5x3uQhbruc8E/4acJnvIsN
         1Xby2mJqtDotBUf4UNvXCRKztlrhu6eKzv43aLBVhIDeofYjmWGAdeNyLxT7t8DKEwHv
         ex4uX9tj2m6wxy+ZegPZOWEtRH39VsAQFeuV1vnTpnBAB+KlW5dhXM+UOod/vSNti+UU
         lm4WauAGOSYzl9cck3zKj8zwS0P+cfr9op+fcYzmJenTr9cw/ba9opf2q+y+LYILIhnf
         UUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181744; x=1726786544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWuMZXE9BAfG5V2S6lvMwMxoSKtMEwZr/chmLcyZA3Y=;
        b=BgAmTigpEcGkdO45nFXSwSJu6Ze5b8ZoOmxc9VhZk1q5z7dLbk4dqiILsWBF9NBcTy
         5XLrlEGSYuyfKJ6ygF9Y4cyNI8y1aDjXNztFSMogZcQVii9CfRHfi4VBSLitRiEpT5F+
         VQraz8MFdOZepdPBTVZ6o6v15pdKOljhP9hpeep6YShmQXvj/6xPYr92AkiAwsaYinAh
         XGL8F0HsCan9qbPRyd3TbpdLjB9SlRfZZeMsCWBDAeR7yWFWONchPsYcnMb5oQFgJY2L
         Bg+sLaG8FWvuwQoabXzLhjsiqHPeYMSYjNfv7dTSSB8jKUa5kQqh2p1WzTEWCACk6F2N
         +P/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdbRT8aMDsp4TdCs9nn6dnckiKphU6VKldPUW7HXa4P+eNDaTzFY1WSo2FVcHN4/kDilC9x/F7B16TO2o=@vger.kernel.org, AJvYcCXgfb6QtzzHtQ6h9bFpSGU18L8nxoIxOTmLV9ENPLBGHYkRBr6SQJxmB8cXQ/J1drtehQqsF9du5XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTC0yJImJoZne+r9AShFzpJV5GlFgnMNLhIjFnGDPqqZckMEI
	RVXjgmqn0Wu4FqnKfHNb1BVzipLKMrEYX6i63vRYsVcw7DD1MqvveWn0CA==
X-Google-Smtp-Source: AGHT+IG4m9xRCD0geWalANohIYIaiTFjMIB0Nd7SodDb983G6xvkB0yUJcB1tcQU2ZcRFLxi3eLsiw==
X-Received: by 2002:a17:902:c945:b0:207:5f56:4788 with SMTP id d9443c01a7336-2076e4768eemr51110465ad.60.1726181743715;
        Thu, 12 Sep 2024 15:55:43 -0700 (PDT)
Received: from localhost.localdomain (111-240-84-197.dynamic-ip.hinet.net. [111.240.84.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b0083efsm18674825ad.244.2024.09.12.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:55:43 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: skhan@linuxfoundation.org
Cc: jkacur@redhat.com,
	jwyatt@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	minhuadotchen@gmail.com,
	shuah@kernel.org,
	trenn@suse.com
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
Date: Fri, 13 Sep 2024 06:55:19 +0800
Message-ID: <20240912225519.119392-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b64402ad-4c0d-4f5f-939b-4be1a7855e4a@linuxfoundation.org>
References: <b64402ad-4c0d-4f5f-939b-4be1a7855e4a@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AFAIK,
raw_pylibcpupower.i is not a generated file, it is a interface file
for swig.

The *.i file extension is also used for pre-processor output
(single target build) and all *.i files are removed by 'make mrproper',
including raw_pylibcpupower.i (should not be removed).


thanks,
Min-Hua
>
>
>> I have reviewed and tested and this. I am good with it being a stopgap.
>
>I am okay with the stopgap, but I do want i explore other solutions.
>> 
>> Please send the non-rfc patch.
>> 
>> Thank you for reporting and sending a patch for this Min-Hua.
>> 
>> Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
>> Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
>> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
>> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
>> 

