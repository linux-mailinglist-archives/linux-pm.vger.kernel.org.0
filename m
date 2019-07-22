Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0185970CAE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfGVWdl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 18:33:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37625 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfGVWdl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 18:33:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so18053716pfa.4
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OiNiLucFHzcy62Q/uV7Rl20nKJBchzgLzRjk8lPRvTI=;
        b=EM1IgF0DVayCa3ZHqu5MQDHFJSfM22gDk5jlUi2ZxHVKw4BV+5cVEkxIY1MV8UfbfF
         3rOaf+MSnOe8YwY66/Uptf55irntWYTmMTcnr0/ZptEkCnX6Gesp19VgY45q++QW2LbI
         6yDY21e3Pb8fFwKbQEVg44xtGV5fQyPv6X3Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OiNiLucFHzcy62Q/uV7Rl20nKJBchzgLzRjk8lPRvTI=;
        b=VceYOpkCqzaav/0Gd08V2ujAsxhOTX1eE4imD4b7WpPzTc7e3nF7OqHJj1RkNKmkK0
         sXB4iB0LSg/mzvf4d7/FrH8wjC3oyQ/mZaLaL411emDsSeq8I69Y2vGnM3+SSK7f2YT6
         ff87r/r+P6yoJhh4b4fz37oj4HtD+W5pitLkCpabNFBPNVKQUkmjuyFodFw5mHCixRDb
         tT51mA+yhRJI5+mvQP43jVuhnpE6jwcX1rMOhBxU23BkGPLsko4CBqORajbOEqp90Mi0
         Iex9BxK4694xNjCAk8oMv1cvspA7M7eTm+HDkoDHD2ad+c0Qw8rczRd5RJfzR6k+P1m8
         FcuA==
X-Gm-Message-State: APjAAAVfamNCoKPrYZDk4SjWiowAGikYXR7V48I8+gKHd5r7fUInN/XC
        Y1OAu/zMgSKcTepT8gPrbJ1NaQ==
X-Google-Smtp-Source: APXvYqyVI6/r2/2vccLiPS9z4xcidbOTHjITUeNO/JzPjKOnDzA7LRMstmsIGWAscqES/rL2AkAPiQ==
X-Received: by 2002:a17:90a:cb8e:: with SMTP id a14mr30424267pju.124.1563834820452;
        Mon, 22 Jul 2019 15:33:40 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id k186sm20614285pga.68.2019.07.22.15.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 15:33:39 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: [PATCH 0/2] power: Refactor device level sysfs.
Date:   Mon, 22 Jul 2019 15:33:35 -0700
Message-Id: <20190722223337.36199-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722182451.GB24412@kroah.com>
References: <20190722182451.GB24412@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

wakeup_abort_count and wakeup_count attributes print the
same (wakeup_count) variable. Thus this patchset removes the
duplicate wakeup_abort_count sysfs attribute. This patchset also
exposes event_count as a sysfs attribute.

Ravi Chandra Sadineni (2):
  power: sysfs: Remove wakeup_abort_count attribute.
  power:sysfs: Expose device wakeup_event_count.

 Documentation/ABI/testing/sysfs-devices-power | 36 +++++++++----------
 drivers/base/power/sysfs.c                    | 27 +++++++-------
 2 files changed, 33 insertions(+), 30 deletions(-)

-- 
2.20.1

