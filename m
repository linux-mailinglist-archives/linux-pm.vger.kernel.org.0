Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0E10A0DB
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfKZPBB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 10:01:01 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:35088
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfKZPBB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 10:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574780460;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=24AiegpH7znqjaeLFqjli4zrLM23LRyoX6pngyIrKYg=;
        b=eN56/0VqDwI+v7oufGPe/VBgWJZ09DKmZFNA0F8ol2pYv09U07IoMTpZxlBoLyto
        NVqTem0oAiwfSW/qQtbk5IayxCQQdH//R513FVTVTEOgPM3dXapw1mFQWSAS8QvkKoy
        gxP5bKOnBRDkRNrGPuAz0a8I+eQDUI1IhWNgskTU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574780460;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=24AiegpH7znqjaeLFqjli4zrLM23LRyoX6pngyIrKYg=;
        b=R416rXo3LhP+t5GJSqTTVBt7/7L3sR6BaPSCN2p4XE0iEh4OknMwDzQYPDbmnUt7
        QVzMVenrtirmgs8PBS979bGWYYHxjaYBhtrb3j1h9CBb58FtK/IV+JZxGOeu99XqdJM
        Yg3ikw7QEj/Kq6DEvYH9YwsAxnmpK55EvFbniv38=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CE3DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com, sboyd@kernel.org
Cc:     ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [PATCH V1 0/2] Add SC7180 interconnect provider driver
Date:   Tue, 26 Nov 2019 15:01:00 +0000
Message-ID: <0101016ea83add0b-b8d41e34-b3fe-48db-b64c-defa3a800e15-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
X-SES-Outgoing: 2019.11.26-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver to support scaling of the on-chip interconnects on
the SC7180-based platforms.

Depends-on: Redefine interconnect provider DT nodes for SDM845

Odelu Kukatla (2):
  dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings
  interconnect: qcom: Add SC7180 interconnect provider driver

 .../bindings/interconnect/qcom,bcm-voter.yaml      |   1 +
 .../bindings/interconnect/qcom,sc7180.yaml         | 155 ++++
 drivers/interconnect/qcom/Kconfig                  |  10 +
 drivers/interconnect/qcom/Makefile                 |   2 +
 drivers/interconnect/qcom/sc7180.c                 | 843 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sc7180.h     | 149 ++++
 6 files changed, 1160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 create mode 100644 drivers/interconnect/qcom/sc7180.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

