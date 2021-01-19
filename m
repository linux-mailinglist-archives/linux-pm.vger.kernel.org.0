Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C422FC50E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 00:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbhASXhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 18:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395106AbhASOGa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 09:06:30 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333C3C0613C1
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 06:05:44 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 22so21867790qkf.9
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRH1U9XGgfqWEUznDbBjK+ln/wIg4FAs6AUuAcYpjiM=;
        b=DkPzlGL8rpnYUhr0x+ghT+YFzXkOJ7sTyBFKUJGFq8VcsE8h4Sln2lwXqVBHI7Lks4
         xh/4BFR8MqvCwkLi4Q4KsWMPlOCkJH9sfYTbFT68N3+6EfCHlIzkRDwv1hOHGJFGVZDm
         cHu89JimX1mqMVYoGT+644GjIgt9E4B7cnbvChs+RCzqiakB6vsuPv3oJpS2skHBUvSh
         p/BDiaR1LSkvGJuANlc+pvGVEpVgaNXii+Oc9YkOnRPUdY4KgCBBPRZVS8VGvVtBNRDy
         YytAWVFyQ9UpK6+vyh0Rbp+iSLsR/0FlmO5P9UiGEciBE5GqVkbIYlzcwdrIi4b3lBa5
         qHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRH1U9XGgfqWEUznDbBjK+ln/wIg4FAs6AUuAcYpjiM=;
        b=l5tO+cjuF1kVD1ojJ4K5oJCZcwKsA7uhJarXOoS+HAEQlmIHXq+BmVyxIVJdDYJ9lL
         qmgu+falVaIV4l5NneKEeh+Ff3TtTXM8bl1BVeEopWtEth3kFxQ90T1grR6AK2RVLOLu
         7iuMkx798C10XrkOf8taye6ctRWYcxpm8GwWLTjNtMZ91Mzz0SUTjHmrz35UVLBZ5/W8
         ax91EIqtr1q2HsXUyO/xTh/GuXgctmpdMENhBGQCMtU72kFP7OHXxzIho3Cj/oW7WPAR
         271FLI2OTjqIQaO/JpcIVz5KdZtn0HhfYKTEWW4Y76DjRQV5yBIJCg6gnOJhtZY/ZtKg
         Yf8w==
X-Gm-Message-State: AOAM533iXBBdKGCZ0JGb01mTlyyJd/b5tG8f+DPwwcrY2XNwfscBdAus
        ix+usPglG3UGc1DZowxaR9aPuQ==
X-Google-Smtp-Source: ABdhPJyJW/SKWMo//tsJYkLob0dolrZzCo67MSuqy0v+ITqmyMiKwgdxgev8K215pVK2IvL7oX3pHg==
X-Received: by 2002:ae9:f819:: with SMTP id x25mr4369008qkh.429.1611065143335;
        Tue, 19 Jan 2021 06:05:43 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id f134sm12910308qke.85.2021.01.19.06.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:05:42 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
Subject: [PATCH 0/2] thermal: Replace thermal_notify_framework with thermal_zone_device_update
Date:   Tue, 19 Jan 2021 09:05:39 -0500
Message-Id: <20210119140541.2453490-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

thermal_notify_framework just updates for a single trip point where as
thermal_zone_device_update does other bookkeeping like updating the
temperature of the thermal zone, running through the list of trip points
and setting the next trip point etc. Since  the later is a more thorough
version of former, replace thermal_notify_framework with
thermal_zone_device_update. 

Thara Gopinath (2):
  net: wireless: intel: iwlwifi: mvm: tt: Replace
    thermal_notify_framework
  drivers: thermal: Remove thermal_notify_framework

 drivers/net/wireless/intel/iwlwifi/mvm/tt.c |  4 ++--
 drivers/thermal/thermal_core.c              | 18 ------------------
 include/linux/thermal.h                     |  4 ----
 3 files changed, 2 insertions(+), 24 deletions(-)

-- 
2.25.1

