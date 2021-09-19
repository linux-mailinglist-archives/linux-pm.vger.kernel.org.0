Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C159410D3F
	for <lists+linux-pm@lfdr.de>; Sun, 19 Sep 2021 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhISUP4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Sep 2021 16:15:56 -0400
Received: from h03mx16.reliablemail.org ([173.236.90.20]:15581 "EHLO
        h03mx16.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhISUPz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Sep 2021 16:15:55 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2021 16:15:55 EDT
X-Halon-Out: 578ab969-1985-11ec-a67c-00163c72d6d3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XnnylZpKKoip6qobXPOGPzi5vEJgH9r5kYC4SFQRE1c=; b=ZQIorl2A2BUxdoQ3rNw0+33ZR5
        KHmn+B++Ru5bOm9bIWkiuLpBusrh5kurVDEIgDumjGFg2Ck3U/MIFm6CMiFxiih2hcpTRj6gG7xoC
        Iq9uO+xplnnVjxyZgjuq64Jqe7FE7uCSYtEM3fFx7yr30GAp9h5YUoEnZNHUX8whDjKYXbkEh5Yno
        QyAmRn/fpUmvP1w72OAAl8Y3tRGYAdQdfJ2mXMcLoAxyuaYD7ZOzmg4tS6K2whOZ2zOFi7dhqOHzv
        E/IxraTG00xTj85Vx2GNnW/8mLywUclYth7GMw1OTE3xUHpZDVo0TZ06t1fA+y36V6UitgvqdEcAw
        Di3Z7KkQ==;
From:   Henrik Grimler <henrik@grimler.se>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, wolfgit@wiedmeyer.de
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 0/1] power: supply: max17042_battery: use VFSOC for capacity when no rsns
Date:   Sun, 19 Sep 2021 22:07:35 +0200
Message-Id: <20210919200735.142862-1-henrik@grimler.se>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This fixes so that the capacity is correctly reported for Galaxy S3.
It is a v2 of a patch sent by Wolfgang Wiedmeyer some years ago [1].
I have not been able to get in contact with him, but have put him as
Suggested-by acknowledge that it is his fix.  Please let me know if
Co-developed-by, or some other tag combination, is more appropriate
for giving credit in this case.

[1] https://lkml.org/lkml/2016/9/25/195

Best regards,
Henrik Grimler

Henrik Grimler (1):
  power: supply: max17042_battery: use VFSOC for capacity when no rsns

 drivers/power/supply/max17042_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: 6a7ababc0268063d0798c46d5859a90ee996612f
-- 
2.33.0

