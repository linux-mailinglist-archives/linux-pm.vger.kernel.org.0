Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9E11433F4
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 23:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgATWdT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 17:33:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWdT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 17:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6395EwuwLp7BSh0SHkkcV4mhJoN9KeSV8+Z7AuG+fu8=; b=qdGAVTw11fJXgxBM+eQAMaXxy
        1D5Rtb7kkwChm7QKLWThgRIslj0MkAT3Nh8tdZnzBKf04NAnn023dCn3v4MReCFJcqiFJ9lpsrulq
        VBGBFcwGMtRCWq/IsPbNktlx8xHUsz9OTJNoOqMnPVdVOZksbUynpdqa8Y4wtdhhSlD/hb2c+Q7gt
        XVfiwdUli55oTSiwOJghgXCNnlZK+E9t/Yzz3Wp0pOKizHheqUVEKHOi5kF/fb6/3eN2gTN2nvIaz
        Q0naYmLro/AwhffJm81aofZHsBgwwKAyliBny3UxLvmPjQUTrSAppabTsRFXSPcYd9I81TnMJmHDf
        kfs0VGvYQ==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itfbi-0006nI-IH; Mon, 20 Jan 2020 22:33:18 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] Documentation: cpu-idle-cooling: fix a SEVERE docs
 build failure
Message-ID: <712c1152-56b5-307f-b3f3-ed03a30b804a@infradead.org>
Date:   Mon, 20 Jan 2020 14:33:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Sphinx ('make htmldocs') stops with a SEVERE error:


Sphinx parallel build error:
SystemMessage: /home/rdunlap/lnx/next/linux-next-20200120/Documentation/driver-api/thermal/cpu-idle-cooling.rst:69: (SEVERE/4) Unexpected section title.

^
|

so fix the .rst file so that the SEVERE build error does not happen.
Also fix another minor formatting warning (unexpected unindent).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: linux-pm@vger.kernel.org

---
 Documentation/driver-api/thermal/cpu-idle-cooling.rst |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20200120.orig/Documentation/driver-api/thermal/cpu-idle-cooling.rst
+++ linux-next-20200120/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -65,6 +65,8 @@ We use a fixed duration of idle injectio
 performance penalty and a fixed latency. Mitigation can be increased
 or decreased by modulating the duty cycle of the idle injection.
 
+::
+
      ^
      |
      |
@@ -91,6 +93,8 @@ computed.
 The governor will change the cooling device state thus the duty cycle
 and this variation will modulate the cooling effect.
 
+::
+
      ^
      |
      |
@@ -154,6 +158,7 @@ equation:
 
  P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
 			(Trunning + Tidle)
+
   ...
 
  Tidle = Trunning x ((P(opp)running / P(opp)target) - 1)

