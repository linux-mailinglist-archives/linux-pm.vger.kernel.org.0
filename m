Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA1400B1E
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 13:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351520AbhIDLGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Sep 2021 07:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351518AbhIDLG3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Sep 2021 07:06:29 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A64C061757
        for <linux-pm@vger.kernel.org>; Sat,  4 Sep 2021 04:05:28 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DC0731F70E;
        Sat,  4 Sep 2021 13:05:26 +0200 (CEST)
Date:   Sat, 4 Sep 2021 13:05:25 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 11/11] interconnect: qcom: drop DEFINE_QNODE macro
Message-ID: <20210904110525.qjmcp5vfsttzhelh@Marijn-Arch-PC.localdomain>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <20210903232421.1384199-12-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903232421.1384199-12-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-09-04 02:24:21, Dmitry Baryshkov wrote:
> Drop DEFINE_QNODE macro which has become unused.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
