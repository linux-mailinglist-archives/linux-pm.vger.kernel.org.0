Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B498326775
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 20:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZTda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 14:33:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZTd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 14:33:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lFir2-0003gr-59; Fri, 26 Feb 2021 19:32:48 +0000
To:     AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: qcom: tsens-v1: MSM8976 base1 setting
Message-ID: <54dc93e2-9105-0dcf-3d12-af5e29b30afd@canonical.com>
Date:   Fri, 26 Feb 2021 19:32:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi there,

Static analysis with Coverity has found a potential issue in the
following commit:

commit 0e580290170dfb438d911c306b27d89d5b99c1d9
Author: AngeloGioacchino Del Regno <kholk11@gmail.com>
Date:   Sat Oct 5 12:41:31 2019 +0200

    thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976

The analysis is as follows on function calibrate_8976 in
drivers/thermal/qcom/tsens-v1.c:

249        switch (mode) {
250        case TWO_PT_CALIB:

Operands don't affect result (CONSTANT_EXPRESSION_RESULT)

result_independent_of_operands: (qfprom_cdata[2] & 255) >> 8 is 0
regardless of the values of its operands. This occurs as the operand of
assignment.

251                base1 = (qfprom_cdata[2] & MSM8976_BASE1_MASK) >>
MSM8976_BASE1_SHIFT;

MSM8976_BASE1_MASK is 0xff, MSM8976_BASE1_SHIFT is 8, so base1 is always
going to end up as zero no matter what value in qfprom_cdata[2] is. I
don't have any data sheet for this hardware, so I'm not sure of the
exact intention, but I think MSM8976_BASE1_MASK should be 0xff00 - hence
I'm reaching out to report this issue with my understanding of the issue.

Colin
