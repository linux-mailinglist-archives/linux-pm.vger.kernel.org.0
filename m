Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689BA2C8F49
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 21:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgK3Ufj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 15:35:39 -0500
Received: from mout01.posteo.de ([185.67.36.65]:55283 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgK3Ufi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 15:35:38 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id C620016006C
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 21:34:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1606768478; bh=wn0fxikED5e35YRuXe/WDCB8WuBSLCRyKZtGvuyjy4U=;
        h=To:Cc:From:Subject:Date:From;
        b=gPD9tmILKdGTlAN/YaeV6y9pmEr4RzKVYpizJIz9I/VG2J6DfvXBRkppMqUiN5Myj
         qDQ+khgBWXykiAGqB2Ky6hjgVrECHPMEBlsMYasmoZYj4+7uEtr/hv/S+xO12v/9LI
         RObg2+815woWTr1V5LdgYuE2a0PaMvw6TGXwhYc7ipIlLovgJ6Cq8IPWNyY3h1jdM8
         mhwMm0HX984jAsOrIzttwJnYw6A/4LPdJAugilbYvy9+ksRnoOXaFfvtt0VNjvfwId
         rwQMinNV2XeyuxXLzZgkjRylOqIjOQ8miHHg+YOy46l6SMFWGu2k1sNWkQKh9heTPh
         /XBUfv1+kEsqg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ClH5H6q6yz6tmL;
        Mon, 30 Nov 2020 21:34:11 +0100 (CET)
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Leonard Crestez <cdleonard@gmail.com>, akashast@codeaurora.org,
        Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
From:   Martin Kepplinger <martink@posteo.de>
Subject: question: interconnect: changes in 5.10 / imx8mq ?
Message-ID: <c110af2f-635a-71f5-735c-1346b7af0ef9@posteo.de>
Date:   Mon, 30 Nov 2020 21:34:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi,

what I've used on v5.9 on imx8mq in order to hook up dram frequency to 
interconnect (via mxsfb/lcdif) - and has worked fine - is:

* add the NOC node description with "#interconnect-cells = <1>;"
https://source.puri.sm/martin.kepplinger/linux-next/-/commit/8a6b8486a3e94e2886bde01000f9532e03d243a4
(original author is Leonard. I'll preserve authorship when submitting)

* add "interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
" to lcdif:
https://source.puri.sm/martin.kepplinger/linux-next/-/commit/6c4bbcdc315da01a9dc8bbda36290587ce1ed33a

* hook up the driver
https://source.puri.sm/martin.kepplinger/linux-next/-/commit/63679bcfa586578fc4345010a30ff7ac1af4c3c6
(I know this doesn't use devm_* and has to be cleaned up)


on v5.9 this would nicely have the driver's value set:

  node                                  tag          avg         peak
--------------------------------------------------------------------
NOC                                                   0       678900
   30320000.lcd-controller                0            0       678900
DRAM                                                  0       678900
   30320000.lcd-controller                0            0       678900
(...)

now on 5.10, I get dram always running at the highest speed because the 
*node* "requests" a lot, see the interconnect_summary:

  node                                  tag          avg         peak
--------------------------------------------------------------------
NOC                                          2147483647   2147483647
   30320000.lcd-controller                0            0       678900
DRAM                                         2147483647   2147483647
   30320000.lcd-controller                0            0       678900
(...)

the above is with screen on of course, as can be seen by the value from 
the driver. That *is* set to 0 as expected, but still, the "2147483647" 
remains:

  node                                  tag          avg         peak
--------------------------------------------------------------------
NOC                                          2147483647   2147483647
   30320000.lcd-controller                0            0            0
DRAM                                         2147483647   2147483647
   30320000.lcd-controller                0            0            0
(...)



what am I doing wrong on recent kernels?

thanks a lot!

                                   martin
