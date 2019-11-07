Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7EF2E60
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 13:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbfKGMq5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 07:46:57 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41511 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGMq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 07:46:57 -0500
Received: by mail-ed1-f54.google.com with SMTP id a21so1772954edj.8
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:openpgp:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=3UZ64Sq3eqaV71BBDiKRJ7pJQ02szPhuWPuPnRF5ua8=;
        b=TVzP13bc6+rklA1VY1K0u5Gh1wAobf7v8J7dEsA5ZOW6re+W/umx/K5W7RMFRsqhuW
         AJFNr1VAjjqJcJV47/UDkG+zLwWlN3nUCvdf1OKeo9nWmNeVlu/j8FVzzajcFtzKmL+O
         9hj0alf2F7lGSrCD2V9719kzcaMteyD4k5I6vB5/hTEDYXH7KHfYS3sbkErb1SBMxaS6
         I1FQGGHC+apaNDUgiquREFNTWyLjiTs3Gcl7so1G8H6aIOtNkW3BHEGhMM99do8pmBG/
         DDjaP+eG8VKPwzsD7kVYAvcagz6NdRAGHwScgILQFGnEwcBFPFHU53QMAlhsxGW6Xppl
         7fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :mime-version:content-language:content-transfer-encoding;
        bh=3UZ64Sq3eqaV71BBDiKRJ7pJQ02szPhuWPuPnRF5ua8=;
        b=Sa9wwRK1TVmuSyu9UEaFOWeYRGo0+V+yZRU9HjWAa7w8rj4dG9WpqRcN/xfIf6P4XN
         vsy00ubGaO4yWbGWfbOtIM/decPolQdXJjwmF0WvoiBElOtxJMinjI2w3ymG9XoS2EHJ
         ZVx+UNpgNPH4vdfouus/9qjXDymTV0OdlXGgHCEZOkblUS0lwowyDRw3/1YqLStBse2l
         KaC/idQQf6Kos7hJ9Js1kekSaVTplg2Z55wd3oo/1M1h522I5mKo4D/19Oa5CTZGvefa
         /Qkj0P8e9DMjCmNkHa8kxsWsPVtZt0VYf3qCdZTAHLnpsSGjOxOaVkLmkMvL9qisGzqT
         7ZzQ==
X-Gm-Message-State: APjAAAUdVV4wzbmGeZBl0iVJUQiunxDZ3UXQ1PAvrXvRoGXBV1V1WAq+
        U2xBvP8yt7Klwvu7BJ8zVz/Sa104NWs=
X-Google-Smtp-Source: APXvYqwxLGFsmOUY7smS/25Wr44YSCz3ZetiDfk313lHolSsceE66SBuZ93QVpbGr8TNkpzqenfNrw==
X-Received: by 2002:a17:906:a411:: with SMTP id l17mr2829816ejz.274.1573130816031;
        Thu, 07 Nov 2019 04:46:56 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id k4sm30818edc.49.2019.11.07.04.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 04:46:55 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL] interconnect changes for 5.5
Openpgp: preference=signencrypt
Message-ID: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
Date:   Thu, 7 Nov 2019 14:46:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

This is a pull request with interconnect patches for the 5.5 merge window.
All patches have been for a while in linux-next without reported issues. The
details are in the signed tag. Please consider pulling into char-misc-next.

Thanks,
Georgi

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.5-rc1

for you to fetch changes up to 0bf9146d94a00c7759a30241eeabd3e2b28c5f15:

  docs: driver-api: make interconnect title quieter (2019-11-02 04:04:35 +0200)

----------------------------------------------------------------
interconnect patches for 5.5

Here are the interconnect updates for the 5.5-rc1 merge window.

- Disallow the interconnect core to be built as a module, as this will
bring more complexity when this API is called from other frameworks that
are built-in only.
- New interconnect driver for msm8974 platforms.
- Change the initcall level of a driver, so it is available earlier to
other dependent drivers.
- Minor clean-up and a tiny documentation fix.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Brian Masney (2):
      dt-bindings: interconnect: qcom: add msm8974 bindings
      interconnect: qcom: add msm8974 driver

Georgi Djakov (1):
      interconnect: Add locking in icc_set_tag()

Jordan Crouse (2):
      interconnect: Move interconnect drivers to core_initcall
      interconnect: Remove unused module exit code from core

Leonard Crestez (1):
      interconnect: qcom: Fix icc_onecell_data allocation

Louis Taylor (1):
      docs: driver-api: make interconnect title quieter

Viresh Kumar (1):
      interconnect: Disallow interconnect core to be built as a module

 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml |  62 +
 Documentation/driver-api/interconnect.rst                        |   2 +-
 drivers/interconnect/Kconfig                                     |   2 +-
 drivers/interconnect/core.c                                      |  11 +-
 drivers/interconnect/qcom/Kconfig                                |   9 +
 drivers/interconnect/qcom/Makefile                               |   2 +
 drivers/interconnect/qcom/msm8974.c                              | 796 ++++++++
 drivers/interconnect/qcom/qcs404.c                               |  17 +-
 drivers/interconnect/qcom/sdm845.c                               |  16 +-
 include/dt-bindings/interconnect/qcom,msm8974.h                  | 146 ++
 10 files changed, 1051 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 drivers/interconnect/qcom/msm8974.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h
