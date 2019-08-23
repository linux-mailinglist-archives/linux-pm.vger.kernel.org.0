Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9C9B321
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbfHWPO1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 11:14:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39299 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbfHWPO1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 11:14:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id x4so9203145ljj.6
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:openpgp:autocrypt:to:cc:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=NjFtUgkWgGqgPhIrvtkYQJ0NpkM0bLFq/cLwsEsxrLI=;
        b=Pj7yLY4IOHq7i3TwRIPJpx3yhGcQ54DR7d3XcBcuN1exkgzDmlQM09HVoDq2k5/YpL
         jfKNHB+v98u+6otGsd8XolmF/lI6vOXXYgwMbtHhcVttYrIwJ3LN8spSTTdP2836eZaI
         C/r9dS7hOb38CXKUPBb3KBu2hY+FPWuO0ZrVS+EeIpuLaMCOlJcuPAjKJ5wyBFlnXJuk
         4E7IEVv3FEn7xlVO5dwTbK5y/RK3VahqhxOqQsk0Myy1EWcO7yICs1fef7MLqydQZu2/
         QsY88fiFiqX1Sa2u6dEQU0X083C5fIzlNXy3PMvNLEeLHrLsymBxxkiFQec7cE0eFJzw
         7YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:openpgp:autocrypt:to:cc:message-id
         :date:mime-version:content-language:content-transfer-encoding;
        bh=NjFtUgkWgGqgPhIrvtkYQJ0NpkM0bLFq/cLwsEsxrLI=;
        b=bev4D4mMG80/SfEalLR0OL4Hl/mEqHlXCXV4+jkOjLJj9ADhh3ZMqiQorBL2Y0PpHX
         7pDVdlECOD8HHmgiV1DeV9MIGY1gG8PljsS5CYoYmmbK1VKOIGlCYXzKDzASz4xifN/E
         tkdsbyk0AKMti8bxD21SfCw22OWI+PAYeeSwjbQc+O/aJE4gMgA2d7lUJvQvpG/8tpRJ
         s+TrxO45zem05r+AkTzWiZFsG9Z9lmcX4/vEsEZyK75Gj10RgWYx0S8ruXPsuPhhAvja
         OlCb9fMyTa5EnqzT5t7xugucNHY8OAzF54Sai/t77bDD2WbhATlCFiwrqUGqikO8vclC
         AJmA==
X-Gm-Message-State: APjAAAVRitC35/vjz65MgDTp7GF3h31kLphbPqPWZPCIe9UTotUxzfvs
        NYDFiHV/MShjC6T1Jkp9VNVW9g==
X-Google-Smtp-Source: APXvYqxcTiXg6cr4CteT7jok31wyWrKvpE1uLWLnlTJtBBvfIOW4vtNrConNPv2ARbMxHDR8THkL0g==
X-Received: by 2002:a2e:9903:: with SMTP id v3mr3376597lji.37.1566573263991;
        Fri, 23 Aug 2019 08:14:23 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b27sm670355ljb.11.2019.08.23.08.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 08:14:23 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL] interconnect changes for 5.4
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <97f47b2a-7aee-ab4b-7510-43c509db982a@linaro.org>
Date:   Fri, 23 Aug 2019 18:14:19 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

This is a pull request with interconnect patches for the 5.4 merge window.
The patches have been for a while in linux-next without reported issues. The
details are in the signed tag. Please consider pulling into char-misc-next.

Thanks,
Georgi

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.4-rc1

for you to fetch changes up to 6311b6521bcc804e4d2fd45a5640562a7b8b5241:

  drivers: qcom: Add BCM vote macro to header (2019-08-20 10:09:56 +0300)

----------------------------------------------------------------
interconnect patches for 5.4

Here are the interconnect driver updates for the 5.4-rc1 merge window.

- New feature is the path tagging support that helps with grouping and
aggregating the bandwidth requests into separate buckets based on a tag.
- The first user of the path tagging is the Qualcomm sdm845 driver that
now implements support for wake/sleep sets. This allows consumer drivers
to express their bandwidth needs for the different CPU power states.
- New interconnect driver for the qcs404 platforms and a driver that
communicates bandwidth requests with remote processor over shared memory.
- Cleanups and fixes.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Bjorn Andersson (1):
      interconnect: qcom: Add QCS404 interconnect provider driver

David Dai (1):
      interconnect: qcom: Add tagging and wake/sleep support for sdm845

Georgi Djakov (4):
      interconnect: Add support for path tags
      interconnect: Add pre_aggregate() callback
      dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
      interconnect: qcom: Add interconnect RPM over SMD driver

Jordan Crouse (1):
      drivers: qcom: Add BCM vote macro to header

Mao Wenan (1):
      interconnect: qcom: remove COMPILE_TEST from CONFIG_INTERCONNECT_QCOM_QCS404

 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt |  45 +++++++++
 drivers/clk/qcom/clk-rpmh.c                                    |  16 +---
 drivers/interconnect/core.c                                    |  27 +++++-
 drivers/interconnect/qcom/Kconfig                              |  12 +++
 drivers/interconnect/qcom/Makefile                             |   4 +
 drivers/interconnect/qcom/qcs404.c                             | 539
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sdm845.c                             | 160
+++++++++++++++++++++----------
 drivers/interconnect/qcom/smd-rpm.c                            |  77
+++++++++++++++
 drivers/interconnect/qcom/smd-rpm.h                            |  15 +++
 include/dt-bindings/interconnect/qcom,qcs404.h                 |  88
+++++++++++++++++
 include/linux/interconnect-provider.h                          |   7 +-
 include/linux/interconnect.h                                   |   5 +
 include/soc/qcom/tcs.h                                         |  20 +++-
 13 files changed, 948 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h
