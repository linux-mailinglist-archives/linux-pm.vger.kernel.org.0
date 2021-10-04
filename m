Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500EF420A7B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 13:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhJDL6n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 07:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJDL6n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Oct 2021 07:58:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08DF461215;
        Mon,  4 Oct 2021 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633348614;
        bh=QUpuYvCjAfNc3n72wkNFJqwa10iOOGDy5OwyyQbzyYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R3ZlcvagmB45gMsqyv8sPJpG+DXMS4Uf32pWzgtK2GjDbxZn02odVGFkLmpruGUk9
         Q67Fj+g0X1st7KkFK6noIFQFLbkXxo15pf21G1ISPOXOC4/8p7pjaXLc4T2LMBf9ZP
         VzE6SHYeIP3yX2JzveftAhrRbrqIHySL8vAd0AepXlzraUaq5jWCXJpRk1OzkyMG3E
         QXKgqal9XHFx6yitq0YI7B0Sdq0xIcq1unGO/5Z8/xEpnjnsOMFJexW0LE0uQwIP75
         MjnuN5eiCpxfDBcCrftGtDk0BJYvlXcmp8TDf2m9wHbaHxgNdIoT5wl96H5BbfTe63
         SoN4n5p0YawaQ==
Message-ID: <2fe2f8bd-c487-e859-54e1-28e6cb0fdece@kernel.org>
Date:   Mon, 4 Oct 2021 14:56:51 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/11] interconnect: merge AP-owned support into icc-rpm
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <36128ee3-0dad-dbdb-ca66-0d0e45aa0b9d@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <36128ee3-0dad-dbdb-ca66-0d0e45aa0b9d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.09.21 22:40, Dmitry Baryshkov wrote:
> On 04/09/2021 02:24, Dmitry Baryshkov wrote:
>> This patch series merges support for AP-owned and bus QoS from SDM660
>> into common code (icc-rpm.c). MSM8916 and MSM8939 support code is
>> extended to support these features. As I was touching these drivers, per
>> Bjorn's suggestion expand DEFINE_QNODE macros (which makes adding
>> QoS support much easier to review).
>>
>> Dependencies:
>>   - 
>> https://lore.kernel.org/linux-arm-msm/20210902054915.28689-1-shawn.guo@linaro.org/ 
>>
>>   - 
>> https://lore.kernel.org/linux-arm-msm/20210823014003.31391-1-shawn.guo@linaro.org/ 
>>
>>   - 
>> https://lore.kernel.org/linux-arm-msm/20210824043435.23190-1-shawn.guo@linaro.org/ 
>>
>>
>> Changes since v1:
>>   - Rebase on top a2noc clocks support patch.
>>   - Expand DEFINE_QNODE
>>   - Simplify struct qcom_icc_node by moving links to separate array
> 
> Georgi, since all dependencies were pulled in by you, I wanted to 
> remind/ask: do you intend to pull this patchset for 5.16?

Hi Dmitry,
Yes, that's the plan. I just responded with a few minor comments/fixes
to some of the patches. I can just fix them before applying, if you are
fine with these.

Thanks again to all the people involved with this patchset!

Thanks,
Georgi

> 
>>
>> ----------------------------------------------------------------
>> Dmitry Baryshkov (11):
>>        interconnect: icc-rpm: move bus clocks handling into qnoc_probe
>>        interconnect: sdm660: expand DEFINE_QNODE macros
>>        interconnect: sdm660: drop default/unused values
>>        interconnect: sdm660: merge common code into icc-rpm
>>        interconnect: icc-rpm: add support for QoS reg offset
>>        interconnect: msm8916: expand DEFINE_QNODE macros
>>        interconnect: msm8916: add support for AP-owned nodes
>>        interconnect: msm8939: expand DEFINE_QNODE macros
>>        interconnect: msm8939: add support for AP-owned nodes
>>        interconnect: qcs404: expand DEFINE_QNODE macros
>>        interconnect: qcom: drop DEFINE_QNODE macro
>>
>>   drivers/interconnect/qcom/icc-rpm.c |  263 ++++-
>>   drivers/interconnect/qcom/icc-rpm.h |   56 +-
>>   drivers/interconnect/qcom/msm8916.c | 1214 ++++++++++++++++++++--
>>   drivers/interconnect/qcom/msm8939.c | 1283 +++++++++++++++++++++--
>>   drivers/interconnect/qcom/qcs404.c  |  967 +++++++++++++++--
>>   drivers/interconnect/qcom/sdm660.c  | 1940 
>> ++++++++++++++++++++++++-----------
>>   6 files changed, 4815 insertions(+), 908 deletions(-)
>>
>>
> 
> 

