Return-Path: <linux-pm+bounces-14200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E12978935
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 21:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC561C22A29
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64569148833;
	Fri, 13 Sep 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiqJgrq0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF31487DC;
	Fri, 13 Sep 2024 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257556; cv=none; b=OSGXRuHB3PaTKCrhhDia5s0H4iOG1w2cvWNLQhrQpN13xn7TGSym5o7PEWMYRlRDsST8rRuOuujnOxXKH0vScXwWBnt1C1N8MlhlORD1sFccEtZyi55fKAZVaUdvOV+sxZlJW4KrKvzrxcUbFziXLr0EA/G5rTnSSYP28HuLOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257556; c=relaxed/simple;
	bh=QVoPu5UgDsOwNF+b+s5XZQ9uTM5s6DcN1EGM/gmFP0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvExAEh1EBWATBvQ/frdGdGk6sjh+4H4WxMnl7X4pTinJQiD3PNb1EJrXCK3LuHSwRpt72sjsqxw6AbBmVdvwYLarM64qhmhEm5SY7aV7UrUxNirua4htBujJCxGMxQhUT9RisQLxkKR+RCB4VDjCjPkBIWvQW5DRlnRtfPcxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiqJgrq0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068bee21d8so28303115ad.2;
        Fri, 13 Sep 2024 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726257554; x=1726862354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVoPu5UgDsOwNF+b+s5XZQ9uTM5s6DcN1EGM/gmFP0w=;
        b=LiqJgrq0ECeNP51GQX6PXOXWRMsYn11w7byXxFGkLEV74UlnweXLW5ozVn+gOV9aFA
         iBgpkcjlpoMf3VLvJvWsPshe0L4a46ZU1rEAOTm2Pk8DgOKUtgQcmhMd5UwGCIGAnU8Q
         ZfU8AaXl4U/Q3ELrjENKXXdn++15Q3gI1rfRQ2tR3YS/vn1KBmfE8TvR44Ht6dGTTvnc
         cHM6ys6+RfD4zA16rQ1vEA0Ty4jBV+Cu2EzKR5G0hxaYWnY2yJSfq3oJJx4BdcBDK5H3
         OMq/JzXEygOfIemgNU1sSImV3cCPEuKPaDfbanCHZvNlaMztrd0IMZLlpYxEWwqEnwxl
         j0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726257554; x=1726862354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVoPu5UgDsOwNF+b+s5XZQ9uTM5s6DcN1EGM/gmFP0w=;
        b=jbQZo+/FNfLI3hKV5q95E0TPPW2FkWFAqbugizbQ8LuvnkLewVcGvuk0zFlJxYS9eC
         AWsSg5Y49IPyYDoBjfViaYff+RMDx0x9Q/E3xqvJ32Sy5BaxzIqzm0odswEJidEc8DQf
         qpA8jzS5t7ABXLfZmuTqRSdaRNKnANQLQkBSV8CCT17cGwdrhCGvJzIGWoPFaBFiJkZI
         Nw+yPD7qeSBT4LCoplWtGKa96YAtFv9UDAhKyIvCBEkgcsCjnamWJJ0E8XUB3q+sEtoP
         FzFZkh80+JUNAJn2Zu3n2NVkeQ0mLB7t5RJi2o+9jpL1tZZdmUPXaspbn+l3+SDEp5SU
         rHjA==
X-Forwarded-Encrypted: i=1; AJvYcCV6O4ckH8kmivp1ZlD68aNY4FLVaM+WAPuGsRnqd//4zeBdfKWRMDMx1K83l6swHUHkutis9v4kvAM=@vger.kernel.org, AJvYcCWUUtvs2Xquah0tX1TQoYyEsVgys4xLk84fMJpKmMW3ynyxoy0meMAb+Li4/LfskEhSuw5OmuLCBRB+rVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaeWXZLi87JCkc0vd/a8+wqdEywAa3I0RDoHbocrJ+rlRRcVIS
	JK5QBTyddcaB8SAEqot8XNS5nbZVBkGhf3WFXlGN5TRN3oYwY3gY
X-Google-Smtp-Source: AGHT+IEcQ6djuD5zFPAim6v6THvher5zETymPAYgSd11RBJx1VLMGIexPb5FxwgF+tAvHyoinfHNrg==
X-Received: by 2002:a17:902:d54a:b0:202:9b7:1dc with SMTP id d9443c01a7336-2076e44ba5emr92889665ad.54.1726257554153;
        Fri, 13 Sep 2024 12:59:14 -0700 (PDT)
Received: from localhost.localdomain (111-240-84-197.dynamic-ip.hinet.net. [111.240.84.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794605706sm204985ad.117.2024.09.13.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 12:59:13 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: jwyatt@redhat.com
Cc: jkacur@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	minhuadotchen@gmail.com,
	sageofredondo@gmail.com,
	shuah@kernel.org,
	trenn@suse.com
Subject: Re: [PATCH v2 for-next] pm: cpupower: rename raw_pylibcpupower.i
Date: Sat, 14 Sep 2024 03:58:49 +0800
Message-ID: <20240913195849.805-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZuRqkbJixRQEScYA@rhfedora>
References: <ZuRqkbJixRQEScYA@rhfedora>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On Fri, Sep 13, 2024 at 07:01:00AM +0800, Min-Hua Chen wrote:
>
>> To fix it, rename raw_pylibcpupower.i to raw_pylibcpupower.if.
>
>Would you please rename this to .swg instead?

No problem, I will send patch v3 for this.

>
>'''
>5.1.1 Input format
>
>As input, SWIG expects a file containing ISO C/C++ declarations and special
>SWIG directives. More often than not, this is a special SWIG interface file
>which is usually denoted with a special .i or .swg suffix.
>'''

Thanks for sharing the document, using .swg extension looks a better solution.


cheers,
Min-Hua

>
>https://www.swig.org/Doc4.2/SWIG.html
>
>I tested it and .swg is not removed by 'make clean' or 'make mrproper'.
>
>My apologies for the extra work Min-Hua. I can send a quick patch
>instead if you wish.

