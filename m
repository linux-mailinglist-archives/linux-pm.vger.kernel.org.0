Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A33B79CB29
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjILJIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjILJIC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 05:08:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F219A1
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 02:07:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-271c700efb2so3560347a91.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694509678; x=1695114478; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4A6fM5ly+otGKA8MWVxPXIy9mabpqxQXrWrt6zRDXo=;
        b=OlEDaf1IPpbu7Assi50BzedxIIpNofQ8H5KYQf+0diMAMONw3mlL+T4fXRSP6u38k+
         wa1/7J4nMLWzP0n7hU137tYrZgT3cKd1wxfWrD3YiLoAwmJq0B+9YZXG8I6rWTWrA3bq
         6z0QTp8nkoTPJS5GguqyI0OexmsI6d996X5//WX2U8jB0aKwGYtOzTwaaBZQzh3aeJVZ
         HYhpKCI+3SfQ/aa8wyoUU7iv6/PRW4dmve55B0KUoVmPDKthELJR8axBb3/eokMS5ZR5
         3gwwxVxG4Rxg20sZlOpRttRMPOx0MavPBsQCZAquR0bPF6NpokQ9X7qo0m1ofldTEqJN
         S3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509678; x=1695114478;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4A6fM5ly+otGKA8MWVxPXIy9mabpqxQXrWrt6zRDXo=;
        b=fWiSIMmPzKZsXrd9eyn/4GIL1naFg7VCvgfDSyedwKil+ZJFuBR60Jicn1mYSHsoDS
         y7HLY8a8P9FjJhixWXNEUmECFj49q+gQOW0UkOEotJiy6eQDeToNMivHu5KJ0LVL60yL
         NzhFaziMxEYSxb/P1xIO7L2YN+nwijhBAYFDY/AqJ9fmOZ2d0tGMsj1Nsf0R5Y19TpO9
         TEQCiRkx/aNNMMgjMeDxLU2yC5sfhGgWBbAE2aHDIvXIwGoSVWvpZSF/LbEggOpw+rux
         gPLpR1QNmm79H6E8GutAHHzvKx0unb3LcOHwIphByhy4zAThW7MtraQ5GIfcxmQq3AZ9
         Wl/g==
X-Gm-Message-State: AOJu0YzixOHcH5iBJ4vhT7OrifMGzdg4Vqg3bugP02jQ9eZwYdDDWjJS
        iuhDi274j5LkqTUGZ0LsyKDXqskTz8w=
X-Google-Smtp-Source: AGHT+IEHCq/1jQkYRPSppagkbllFusA4A4UfA2luu2g0/SUmetnUlDUkfOjtUe71BaNN2XE3acnAEw==
X-Received: by 2002:a17:90a:d509:b0:26b:1269:d801 with SMTP id t9-20020a17090ad50900b0026b1269d801mr8833361pju.14.1694509677724;
        Tue, 12 Sep 2023 02:07:57 -0700 (PDT)
Received: from localhost ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id n62-20020a17090a2cc400b0026b0b4ed7b1sm9485858pjd.15.2023.09.12.02.07.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Sep 2023 02:07:57 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:07:53 +0800
From:   "Jiazi.Li" <jqqlijiazi@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org
Subject: Overflow issue in trans_stat_show
Message-ID: <20230912090753.GA14603@Jiazi.Li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

In trans_stat_show, if there are more than 19 states, len will be
greater than 4096, causing overflow write issue:
[  702.286732] cat: dev_attr_show: trans_stat_show.cfi_jt+0x0/0x8 returned bad count
[  702.287867] cat: fill_read_buffer: dev_attr_show.cfi_jt+0x0/0x8 returned bad count
And then system oops due to memory corruption.

It seems difficult to read more than PAGE_SIZE bytes through sysfs,
could we move trans_stat to debugfs?
For example, in the following dir:
debugfs_root/devfreq/device_name/trans_stat

Best regards
