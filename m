Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581AA2A9064
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgKFHeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:34:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38252 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbgKFHeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:34:14 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A67WHnH010171;
        Fri, 6 Nov 2020 08:34:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=hPyC0/74yWJK+Ac9p1ycHb4o7bsA/mfpFNODsdNnscE=;
 b=WYY/q3v9cTSi8KDOJLnDgEXffaYk2JtBK37Xm4QAbatpLS8qT/eU64faX5jjzx64mU1y
 3Ry3iIJC9phNxH0O3fmDR4lcjEqFKeN+hUUyLgaB03kgU5MdTEGRWpH9B4QESMODLtOV
 jEpTg5j14G9LkvN7qY+A6OQT9l8kgkroDVBUuMQ/PU/cRDdLlYP4Z1V8bzayzay7olz6
 ZN6ScKqvEDBHtzK9eH0TmK9YC83FOWMhrR+RpNJr2Ys6gCGekLkXGcP8U4bBkZeMdKxI
 Muvw4OHbDPxUCvrEBWdAT2Ogeey3N0lFlll2/2wbRlkKSEeJKDVCtHCQlITZbCcX8w/u YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywrckrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:34:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A3DE10002A;
        Fri,  6 Nov 2020 08:34:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 38623226678;
        Fri,  6 Nov 2020 08:34:07 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 08:34:06
 +0100
From:   <patrice.chotard@st.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
CC:     <patrice.chotard@st.com>, Erwan Le Ray <erwan.leray@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <amelie.delaunay@st.com>
Subject: [PATCH v1 0/4] PM: Add dev_wakeup_path() helper
Date:   Fri, 6 Nov 2020 08:33:54 +0100
Message-ID: <20201106073358.8379-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_02:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Add dev_wakeup_path() helper to avoid to spread
dev->power.wakeup_path test in drivers.

Cc: amelie.delaunay@st.com,
    erwan_leray@st.com,
    fabrice.gasnier@st.com,
    alexandre.torgue@st.com,
    alain.volmat@st.com,
    pierre-yves.mordret@st.com

*** BLURB HERE ***

Patrice Chotard (4):
  PM / wakeup: Add dev_wakeup_path() helper
  PM: domains: Make usage of device_wakeup_path() helper
  PM: core: Make usage of device_wakeup_path() helper
  i2c: stm32f7: Make usage of dev_wakeup_path() helper

 drivers/base/power/domain.c      |  4 ++--
 drivers/base/power/main.c        |  4 ++--
 drivers/i2c/busses/i2c-stm32f7.c |  4 ++--
 include/linux/pm_wakeup.h        | 10 ++++++++++
 4 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.17.1

