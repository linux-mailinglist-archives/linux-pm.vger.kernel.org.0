Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 196FFF6DB3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 06:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKKFCw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 00:02:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37262 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKFCw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 00:02:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id p24so9852234pfn.4
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2019 21:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=53M8Gv1/AvgMB2CW8Zp8vzLr5XHj7+CATzsscWfYhnk=;
        b=JVu+6GxITuKEFBtxOnZfeImo8ZjZ2SlcehegPVxYvHwBzmW4gxH4uVqef2orbJWUxx
         R3yQgwWiijyKG1RAD+PBiSYt2gjCtcuiAQERYGqja9ZUrTWdq6q77abQ+fE9AUfvLqgF
         a7TEDcpbF5DQFg4hKYW3OA0BV4zSoFYNYaGHQrSlFWK7KpRGmLI5NEUjCP6DfSo3B36E
         fLXdG1zi6vwlZiRGKt511YjkICRAcR2QyionnWZVy4+Fj8RqeK9PUMysxp/9PLJdfuf3
         GgRC8gf1fDGArRET/ryuvR1ed4qRyOWGQ9YAjpEIOVdrV37QH7ESEVsjrtJ8XYcW3IYO
         +qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=53M8Gv1/AvgMB2CW8Zp8vzLr5XHj7+CATzsscWfYhnk=;
        b=b0feB8n+RXO7B+1/Y/AFfutjmC85FbLYAMmFzqR1V9P67MgcVmmRJ/YEuY3ZISUh4H
         PB6CzpTnee4Hcc+AErrPwYlsat0F02I8kTNnSGWssNK9dDK94PSwfp9rdTOffmMxBxmm
         Ps+76tBuitetRDDGDlhH3D326MRFwlVB+X2XiGYROQueTOue4ZvoqBGXSS20WJr0ZRzu
         ATnCsOkZmeqeTWq8b36SWvLeJEKc7zt/Aiows9LjJ7duKbgHmR6WUso3Ezt3FyU6dYMP
         tnyz85US7vLrAJHZqVCpuwahQxhPGeQuJY74yrjol0d4moPI83TaYaaGHgGMEdWbYZ3k
         erJA==
X-Gm-Message-State: APjAAAV+8ox7QH4VNR4GpgsOZFt9mIpYGBISKg5YPu/5z53d2pH14CMY
        9G8IXq0q911KGNYG/Ll/uF00jQ==
X-Google-Smtp-Source: APXvYqxuIZGaooBgyfYUaLpO9CU00MH3yE/K/AtFVfavBBjffS+u6YbPDq1x9FLiqX8MTkQip8lQOg==
X-Received: by 2002:a63:5206:: with SMTP id g6mr3365406pgb.49.1573448569607;
        Sun, 10 Nov 2019 21:02:49 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id n62sm14361473pjc.6.2019.11.10.21.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 21:02:48 -0800 (PST)
Date:   Mon, 11 Nov 2019 10:32:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP changes for 5.5
Message-ID: <20191111050246.b7vcuhtp25354r2x@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains a single patch to allow modification of the
OPP voltages at run time.

--
viresh

-------------------------8<-------------------------
The following changes since commit b19c23551be8de0d4e59fe6af70f10763e3cc595:

  opp: Reinitialize the list_kref before adding the static OPPs again (2019-10-23 10:58:44 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 25cb20a212a1f989385dfe23230817e69c62bee5:

  PM / OPP: Support adjusting OPP voltages at runtime (2019-11-11 10:27:15 +0530)

----------------------------------------------------------------
Stephen Boyd (1):
      PM / OPP: Support adjusting OPP voltages at runtime

 drivers/opp/core.c     | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 13 ++++++++++
 2 files changed, 82 insertions(+)

