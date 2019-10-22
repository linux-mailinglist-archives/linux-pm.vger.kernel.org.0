Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA8E0603
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfJVOIw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 10:08:52 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46985 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJVOIw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 10:08:52 -0400
Received: by mail-wr1-f51.google.com with SMTP id n15so7450886wrw.13
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:from:subject:openpgp:cc:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=gZd1p6fUssdVq9L3/zQnlWDjkbzH5VjZcJqBdDJdR9g=;
        b=keHs2RpNHJdPkb6uEUy9aPA5uOwZGIgiKzr7hjcHSht944XIqlyXIkEh36Z5ImF2ut
         FGfc24+pz7Tyb0U62ZJG24ULnyNDZmzkUa8ISCWjuvq2d4RdMaPSasnDnSDZu1HrdTtA
         F1GnjDJ5bm5zioxzlrNME5nNCnCc+kc/dcT0SE/V743y6KuMzj7mJigk00Z+VmREl/cY
         HKqelj9dHtjLwLswgJaAW1N6YNb/eBpUDeHzrgvjCERb6xiSpSd0XkYjNPUKuEqV0KAd
         yMqCsAfGiu2biHYzaFn/J3R60/sPcpKj5/IYWv14xo5XCTsS+I7LlmQbPCuocLSG8A6H
         U3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:cc:message-id:date
         :mime-version:content-language:content-transfer-encoding;
        bh=gZd1p6fUssdVq9L3/zQnlWDjkbzH5VjZcJqBdDJdR9g=;
        b=Z14EiyMTheGgiI1TgiqrwjxbZITaecASdjUVsGt4k+hnNWL9KyUWxX9SYeT1338mpL
         ojljnGYIvWQkxc+IauZkx+GfRCUBxRhiSMNimOUosn2NgLNuwkELGjyiZ6gLXhqJvR9P
         THM8wXwLUvALK36OHd5/A5kIS2TVLa5Zgjw9DIjaZJRwxR8GPZkYTOF74j5LdGO1O6ty
         7LolR/FZk6ALNzr+5q00I97+o0UTyF5j5B747PCWXAXTVHI/lFQHYTORzZmUW2cFvyE0
         SLHndeSGS9nUwDCMEWFCR34FzIE7htgJLchXpfnni2MWyytux81nVqzZh7no2swFrA/T
         f1iQ==
X-Gm-Message-State: APjAAAW//sgTbV8iPcDH3IssHh8MIc12E/MelmxbLpxdfg21Jg5BEuT6
        p3Sy9qPAbyiEjLu196z68HMZqQ==
X-Google-Smtp-Source: APXvYqxWclLCiBW43xRG3JowpwK/J4RNacQW5rqIrov9rEu/uBMIJkFGUQGH6Wt42JWQOxSi3n5P2A==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr3945170wrl.235.1571753330819;
        Tue, 22 Oct 2019 07:08:50 -0700 (PDT)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id l8sm787765wru.22.2019.10.22.07.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:08:49 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL] interconnect fixes for 5.4
Openpgp: preference=signencrypt
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <f9c1befb-9170-5189-6383-3311773c02f2@linaro.org>
Date:   Tue, 22 Oct 2019 17:08:49 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

This is a tiny pull request with interconnect fixes for 5.4-rc. Could you please
take them into char-misc for the next possible rc.

Thanks,
Georgi

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.4-rc5

for you to fetch changes up to a8dfe193a60c6db7c54e03e3f1b96e0aa7244990:

  interconnect: Add locking in icc_set_tag() (2019-10-20 12:14:41 +0300)

----------------------------------------------------------------
interconnect fixes for 5.4

Two tiny fixes for the current release:

- Fix memory allocation size in a driver.
- Add missing mutex.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Georgi Djakov (1):
      interconnect: Add locking in icc_set_tag()

Leonard Crestez (1):
      interconnect: qcom: Fix icc_onecell_data allocation

 drivers/interconnect/core.c        | 4 ++++
 drivers/interconnect/qcom/qcs404.c | 3 ++-
 drivers/interconnect/qcom/sdm845.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)
