Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91C816FCE6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 12:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBZLEY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 06:04:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38632 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbgBZLEY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 06:04:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so2547486wmj.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 03:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qxSMSy0KeSHSnmfmzxCA8fCZhL5WkJv642hS2+p/iXs=;
        b=jdMmd6p57s9T9BTkdnRuKCzYlX8V/mp9wKLj+xSR4sQ85knTGnynU+J+MWkInqs2G3
         TuOxOkfik5PXGlBUnFPzJEE4FZQUtrvS1kQari9lhsZEx33vjY57Pv2TWD3gnunzn1uK
         2lGKdc9aIHSaZghpF//01eQMTusQNhrQfGFDfMiQzr9u/E5eGkm+twh6I6jhMXdSnmFQ
         UCY4tiRHf7WgClGpkoMbI9BS9fGDhLY7gU8P+9dTKlKg9FI8GPqR7SmJ+p2aq+FQtgcR
         XqIaCN80VtwFWXsvx59xJIHqf5SQe+Kk5FmWfgddnqMWpkOy5wwrDF054l771/6qjUkc
         XthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qxSMSy0KeSHSnmfmzxCA8fCZhL5WkJv642hS2+p/iXs=;
        b=J9Cn4PAdClpTuCW22cZH+i+LxHfq5ujM77S9wIm2vxoOP7NrtPinATu7j466DbhoWH
         bRd4EZFYzZo0gkuJQrQVH5Q+AaMJKNGsmdMUdpfo71sOwBEX0wINXUCJlGRTqftTdVvD
         shdrBRqR4MxwGC4IEchRd6kdFD7xRIDIrDj9/Tt0KoyPYb5U67HpvFln+/4Wr520RmUE
         1hGVzkmACyvrK9L94g9BQQ77Vc4lo+Rn9NqBZ8gzl18/YGFPy/G3SZxGowomYgpSKAmK
         xSItT/8+ZiSpZZ08HWdEhxrUxXRWXgcND5sciBYyA6P4Ej2ffJXb14bgQW97C53H2jnW
         Nv6w==
X-Gm-Message-State: APjAAAXkFsCtL8qSC/n+vMR65E3iIxLcQAbIrvDKcmChRCOeSVPRFANs
        RUaMcep+22qPVlooVeodgBK3nw==
X-Google-Smtp-Source: APXvYqzo1GIu2NTEmeUo+9/xgeAhx5xgSq3jnjXari1yIps6iOhQfLG8Hjj/EVYP231cndzzGUg9rQ==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr5070418wmb.126.1582715061914;
        Wed, 26 Feb 2020 03:04:21 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h205sm2448176wmf.25.2020.02.26.03.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 03:04:21 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 0/1] interconnect fix for 5.6
Date:   Wed, 26 Feb 2020 13:04:19 +0200
Message-Id: <20200226110420.5357-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,
This is a fix for the current release. Please apply it to char-misc-linus
when you get a chance.

Thanks,
Georgi

Georgi Djakov (1):
  interconnect: Handle memory allocation errors

 drivers/interconnect/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

