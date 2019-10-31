Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63506EB6E6
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJaS26 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:28:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaS26 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:28:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5FCA060A37; Thu, 31 Oct 2019 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572546537;
        bh=S6A2Si/RaS/yk+h2BddahYmgAhOEzg6pGsjlpTqZxRA=;
        h=From:To:Cc:Subject:Date:From;
        b=NKYTn0BIAQpG4Rbn/30sSHLARrUhEb59xdwQl8AYANOuuLInfC3ypNJUtMgsApt/Y
         wohWDNV03E9kFIJ9c9rkfOZNtc4OWe8NWWjor6Ys6QbGJR4K6qn+kH+kuPz4ejbLOk
         3nRm2oMBJpryNC3IDcp+E2YCFphK1smKIHFt6aXQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40A2B60A23;
        Thu, 31 Oct 2019 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572546536;
        bh=S6A2Si/RaS/yk+h2BddahYmgAhOEzg6pGsjlpTqZxRA=;
        h=From:To:Cc:Subject:Date:From;
        b=gV8XTUJOcv1m0B0ENLyxJe9BVSFTMF9nGog+AZSTQ8DZUp170VLotcKxbMpCb+zyz
         mPWD4vcxbP6DfLpdiCfVV/51jJHEfHI113Aem/SmZ7c9cUirojbX9o5NDNKMtUN9u7
         8XfPFEtmgGj/7qpjroBontMtZDm90+j7R6Gv1iC8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40A2B60A23
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 0/2] interconnect: Move qcom interconnect drivers to core_initcall
Date:   Thu, 31 Oct 2019 12:28:50 -0600
Message-Id: <1572546532-19248-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently all the qcom interconnect drivers initialize at the device_initcall
level when they are built-in which is a problem since nearly all the frameworks
and leaf drivers in the SoC depend on interconnect in some fashion. While those
frameworks and drivers should be properly PROBE_DEFER aware it is in our best
interest to try not to defer just because we can. Move all the drivers to
core_initcall when built to increase the chance that they will be available when
their dependent drivers need them.

I also tossed on a quick cleanup patch to remove unneeded module exit code from
the core file since it is always built in.

Regards,
Jordan

Jordan Crouse (2):
  interconnect: Move interconnect drivers to core_initcall
  interconnect: Remove unused module exit code from core

 drivers/interconnect/core.c         |  7 +------
 drivers/interconnect/qcom/msm8974.c | 14 +++++++++++++-
 drivers/interconnect/qcom/qcs404.c  | 14 +++++++++++++-
 drivers/interconnect/qcom/sdm845.c  | 13 ++++++++++++-
 4 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.7.4

