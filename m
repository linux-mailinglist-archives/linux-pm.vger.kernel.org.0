Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0301646D7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 15:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBSOW4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 19 Feb 2020 09:22:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33000 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBSOW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 09:22:56 -0500
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4QFZ-000221-NB
        for linux-pm@vger.kernel.org; Wed, 19 Feb 2020 14:22:53 +0000
Received: by mail-pf1-f200.google.com with SMTP id 203so340345pfx.5
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 06:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=MLzunwtdiwZE8X3dSBg1bcU+Imt/wqtftJaxuJ1ldhU=;
        b=OjVyGUQUP0wg7K7UEkCxfe9SEDfPfVIjUjGcbfTprXcC0qRERqViuqPjCljb9/XpKU
         A56XeqYf2yFE+hRfFDzbi6El+msWGnYieUnDccxcCiVsyy61IUCSSaLq78cHOz5WxFBf
         h2KJdzx1kPZtFdXHj2ZTDIitYcnt4dBeO1Dlq8hpBdIe0USuHTfXFingJF15ezhgdwQq
         j+wiMiG1c8SL6XWcng6G+ZsWGyT81SroFIWlqIud5buYiliP6GQe+7vOO9CD61zr/1xG
         FexM5e+ZDVurHNX76w7qs8Oox4ziUZGWJKKMBB9ot3auBPgLBDndkS32W+bMQoTXdig3
         G+ww==
X-Gm-Message-State: APjAAAUgcy8NRvx4jdAVEwYrBXjrGf1dEg/2kKt235Tm1mzSbCeZWVwy
        IqVZkwtc9N5JFRSXWlBGaU/b//KDgtFVQyDsDrt4mLV3/YYkJE6gpAwtDyQfjvHJCrYmdEhGTXv
        5eQf228GERK9tbhkQmKIaklk/dr26VDm1lj1o
X-Received: by 2002:a63:f84b:: with SMTP id v11mr27755932pgj.133.1582122172399;
        Wed, 19 Feb 2020 06:22:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAf9zQyTPVPbMjR6FbxyzaCj2ekLS3doKIrUEPzVc140+FEtyEVjAoXaVkdyd8BTxOWOpurg==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr27755913pgj.133.1582122172066;
        Wed, 19 Feb 2020 06:22:52 -0800 (PST)
Received: from 2001-b011-380f-3214-7181-50ee-02bc-c2ee.dynamic-ip6.hinet.net (2001-b011-380f-3214-7181-50ee-02bc-c2ee.dynamic-ip6.hinet.net. [2001:b011:380f:3214:7181:50ee:2bc:c2ee])
        by smtp.gmail.com with ESMTPSA id w26sm3190144pfj.119.2020.02.19.06.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 06:22:51 -0800 (PST)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Hard Disk consumes lots of power in s2idle
Message-Id: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
Date:   Wed, 19 Feb 2020 22:22:48 +0800
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-ide@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

Your previous work to support DEVSLP works well on SATA SSDs, so I am asking you the issue I am facing:
Once a laptop has a HDD installed, the power consumption during S2Idle increases ~0.4W, which is quite a lot.
However, HDDs don't seem to support DEVSLP, so I wonder if you know to do proper power management for HDDs?

Kai-Heng
