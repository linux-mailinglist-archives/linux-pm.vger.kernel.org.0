Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDAE25739A
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 08:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgHaGQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 02:16:32 -0400
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:33091 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgHaGQc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 02:16:32 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2020 02:16:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598854279; bh=ot9oPwvCbcx3VziBeqQtXktHy0PvnAf0hNNzlroGiFs=;
        h=From:To:Subject:Date:Message-Id;
        b=Gb83WBSmJW+7LpcT2/C0tJHFwZMECiCEHAEeN+Os8XXe1Dq9Jk9S4cIkDE3LmfoPq
         CfoU9Gd2uwaPO4+4p7byMhDokHVLBZN8ZskPdtKdi+bOJuSAWOvO2v4cceUkWiUDf7
         CtFmG6RJyWyNYdpnN83MBxJ9Os4jPtUyqxwReY+IneFKyRPfuUskn/s9HaL4XzmRrx
         Pcr4glPk194/WnOk/45U4t9S7AB3kVFDOJZGPyuDwXFzrrL0DfCA+ic7n6FBJGJQMi
         Y81FnebSY/nA2UxiCUqnIOgBwXwY4LiDB+RLs3jtAYU7Ss70PfO/xwk/25wnXKJu/E
         9g5BO7ZhAAv9w==
Received: from localhost (unknown [80.214.144.204])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id BF8289A04C8;
        Mon, 31 Aug 2020 06:11:18 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 2/3] cpufreq: dt-platdev: Blacklist st,stih418 SoC
Date:   Mon, 31 Aug 2020 08:10:12 +0200
Message-Id: <20200831061013.4327-3-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831061013.4327-1-avolmat@me.com>
References: <20200831061013.4327-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_01:2020-08-28,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008310043
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add st,stih418 SoC in the blacklist since the cpufreq driver
for this platform is already registering the driver.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 7d01df7bfa6c..3776d960f405 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -137,6 +137,7 @@ static const struct of_device_id blacklist[] __initconst = {
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
+	{ .compatible = "st,stih418", },
 
 	{ .compatible = "sigma,tango4", },
 
-- 
2.17.1

