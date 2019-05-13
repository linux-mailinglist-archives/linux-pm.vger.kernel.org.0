Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F931BE53
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 22:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfEMUEI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 16:04:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43439 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMUEI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 16:04:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id t22so7307253pgi.10;
        Mon, 13 May 2019 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCX+3mB/YRhT5Txkq/+vTAXr74I/DRaeAJEWUAtSVeA=;
        b=nOZpGpq3KZZ5EHYSvows9Xj+60EQgeruNQIjWxTJmxEe3GYdspbxPIR3K6fo/sRW5S
         5nvGfYXcbNKi8//wYPgKLrPqMXmjBx2k5g4T69eJrHp9+dCeaxTCX/gHo1kg2hUPq85u
         VibcARNDu1igrCDQ1GOvxC6Zgx50pMvs/npXjnnWum1C7b2uuiiBbL4+/YuYZO9YGIlz
         XnkFIyrKez5hT2oYR9hXNSUAN3uLc37G8o/shgYm82GorG8XVUOoZiKzP9VToR9NMF9K
         Pn0Z4MHA5ggbCKcTMP5/1Sp3aDASPu3Qpe1TaB3weFyZwnD/BXROJX9Wlg0rbUp82mCo
         A2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCX+3mB/YRhT5Txkq/+vTAXr74I/DRaeAJEWUAtSVeA=;
        b=ZfTzKEYNEHE3z2wd1ZhiyPXDn5Yhykf9swB2BCXb4e7pnMDNw/QxR8rgzmG4lWcbII
         PaHct2RVL8bIxFZlW+ofwFHf+U6NW92HQPqH3qNHYTHX2EQWUsIyC0v/bxnCiTgoce0W
         hLscebkeEpfnHPok6v0oDC++ITKTmg/p+yMdpH+kMaQG6HYDrQTLb/m7o0c51QDfKrse
         bSEvsp3Pp/WgA7YPLMSWJ8w3BjQOpv0gTtX1vZERJcaYmvebep66CaDXQvSOaKXmFFBo
         YsL4SA1MN8WtzvDHy0GOiDKi3U79iJ+5Hp4C6PzPG4s3j+cUhgAKA1ZmHv9W0oboxCkr
         pTJw==
X-Gm-Message-State: APjAAAUNbR7qgK6xB4rtY7akqSAcKDJLhiD0/3PSZ3TlWRalbX2KCZ74
        /Bcs9dwNDD+ei7THqHg/5QgA4q29
X-Google-Smtp-Source: APXvYqyZV6ybo1VVP5ctLbknniFMM7PH3nA4meYMldAwcz49ykSytRnOUwv8TbMfVv0Q/0u77DEDBg==
X-Received: by 2002:a63:8449:: with SMTP id k70mr33268681pgd.53.1557777847892;
        Mon, 13 May 2019 13:04:07 -0700 (PDT)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp. [118.155.13.174])
        by smtp.gmail.com with ESMTPSA id y3sm19167506pfe.9.2019.05.13.13.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 13:04:04 -0700 (PDT)
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT v3 0/3] thermal: rcar_gen3_thermal: Update calculation formula due to HW evaluation 
Date:   Tue, 14 May 2019 05:03:52 +0900
Message-Id: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series was inspired by a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

This series is based on the master branch of Linus Torvalds's linux tree.

v3 [Yoshihiro Kaneko]
* As suggested by Simon Horman
- Patch 1/3: change the types of ths_tj_1 to int
* As suggested by Niklas Söderlund
- Patch 2/3: rename tj_2 into tj_t to accord with the datasheet

v2 [Yoshihiro Kaneko]
* As suggested by Simon Horman
- split into three patches
- avoid global variables
- marked thcode const

Yoshihiro Kaneko (3):
  thermal: rcar_gen3_thermal: Update value of Tj_1
  thermal: rcar_gen3_thermal: Update calculation formula of IRQTEMP
  thermal: rcar_gen3_thermal: Update temperature conversion method

 drivers/thermal/rcar_gen3_thermal.c | 92 ++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 32 deletions(-)

-- 
1.9.1

