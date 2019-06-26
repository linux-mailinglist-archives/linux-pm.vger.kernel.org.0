Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC1562FE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 09:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfFZHQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 03:16:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42938 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHQr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 03:16:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id k13so753826pgq.9
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 00:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=GBgz2zxRKo7LwKCMna1PGQhE3Fg08lReYBXuVZ2+GBM=;
        b=rXDiIuqEtg658UiMKgaorivC9C4DW7kn2XH9YB4VEVboUVIgXASar5MPR6Hn19S9zh
         62dHQtc6etth32w0MJf433pmZSOUHDZba+C0Sn2co9ezBJssj/NTemnrDwUI9LWK+c9M
         81YeiyCUduGfl9XiDVfUSKUnFD0jPBZHw5rhM7i9pW3wc/71x733zNfR2J9OVI0C+/uT
         QM8m2QXc/3okQVhPAwYnXSxNFTcCuC0aR9AcqoPRWJgLQ6ogHXVbGYbYSkPHu/XC62sI
         fH9XD44Lk4iRziOhJmc9ZFQKZCQ9D3g5QHGgKLhZJaT21OP8uQIFiyrqsppJld7x4/RY
         M1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=GBgz2zxRKo7LwKCMna1PGQhE3Fg08lReYBXuVZ2+GBM=;
        b=FDqrep+GNtqMrX7LtXg2r8W3ngpCb9dXLzOQpgERgHLc4aBmRKoRCoQu/4fjjUNyGB
         WqZXhGng2rzk6fNWVi7a9pj1d43jTDTd4RAe/BCbH67Afs4AH61hqT3md4QATC7796QA
         A3STgLdhIqlycH2C3s+p9X4ASyo9r1igYhVETn/hStFunIzuYdLP4ngWtIFvJyLlfK4P
         dBRlx3QIKQHbiaOxgHtQMEu0xe5lS0Gen9Lnvmi13YKYiHhKFYBd0nOzDClpD5MYJxk2
         sKPimG574Z7Q2/tvBp0NE3UZyzy9Ydrp/3pcmU35ffl0pJslX5BOLPe9lzl20/hln57x
         SHZQ==
X-Gm-Message-State: APjAAAUsNnTwkqS5jan2odfiha4NRuaMFrF8JDRHVNQptvvD9roquZOx
        Z85gz6jrKquHfvdC0VGCHuAajg==
X-Google-Smtp-Source: APXvYqwSFr8Oz8v567AMinZZktSUOrace3/EXr31DX0JBDzvHup+91Tc86Q1uswQDvL4vkgquHFvBQ==
X-Received: by 2002:a63:d847:: with SMTP id k7mr1421741pgj.283.1561533406743;
        Wed, 26 Jun 2019 00:16:46 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id t24sm17087487pfh.113.2019.06.26.00.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 00:16:46 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:46:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.3
Message-ID: <20190626071643.enxekm6qxx4qgpht@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Minor fixes for brcmstb driver (Florian).
- New imx-cpufreq driver, its bindings and code around it (Leonard).
- New Raspberry Pi driver (Nicolas).
- Minor fix for s5pv210 driver (Pawel).
- Minor cleanup for armada driver (YueHaibing).

--
viresh

-------------------------8<-------------------------
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to f9020441dbc39133591ff72b420f21f51896afc5:

  cpufreq: s5pv210: Don't flood kernel log after cpufreq change (2019-06-24 10:27:02 +0530)

----------------------------------------------------------------
Florian Fainelli (2):
      cpufreq: brcmstb-avs-cpufreq: Fix initial command check
      cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency

Leonard Crestez (5):
      cpufreq: Add imx-cpufreq-dt driver
      dt-bindings: imx-cpufreq-dt: Document opp-supported-hw usage
      cpufreq: imx-cpufreq-dt: Fix no OPPs available on unfused parts
      cpufreq: imx-cpufreq-dt: Remove global platform match list
      cpufreq: Switch imx7d to imx-cpufreq-dt for speed grading

Nicolas Saenz Julienne (1):
      cpufreq: add driver for Raspberry Pi

Paweł Chmiel (1):
      cpufreq: s5pv210: Don't flood kernel log after cpufreq change

YueHaibing (1):
      cpufreq: armada-37xx: Remove set but not used variable 'freq'

 .../devicetree/bindings/cpufreq/imx-cpufreq-dt.txt | 37 +++++++++
 drivers/cpufreq/Kconfig.arm                        | 17 ++++
 drivers/cpufreq/Makefile                           |  2 +
 drivers/cpufreq/armada-37xx-cpufreq.c              |  4 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              | 12 +--
 drivers/cpufreq/cpufreq-dt-platdev.c               |  5 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   | 97 ++++++++++++++++++++++
 drivers/cpufreq/raspberrypi-cpufreq.c              | 97 ++++++++++++++++++++++
 drivers/cpufreq/s5pv210-cpufreq.c                  |  2 +-
 drivers/soc/imx/soc-imx8.c                         |  3 +
 10 files changed, 265 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt
 create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c
 create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c

