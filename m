Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF48BC24
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfHMOyF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 10:54:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40598 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbfHMOxs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 10:53:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so76966949lff.7
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ebrdQpGbryAbE+PVSjTFqlvSSqkSS1ZgUmlnEvCria0=;
        b=ePZ0JHbra+U1kuq1bS8PxUS1CRnF7QVaKlFGUIrgNjPDCu4+CCfrMg478Kb1CtUJH5
         vwdSrpBbXu81gGSt/pIg2vEHaMMOkhg+qpcLnEPCeBtgzNkT5Sw77IW4fkugaERdtQ6k
         gBW79xeVntMdVPqPn+LET9tGnch6A4FieJNKmotqtgIaWkiqCiktVaIjlgkJbLXo3Am1
         UeuWkhbrgOeNuAdaSume6zhNLlQ5n3/wgIU52bR+GtcKp6Bi40tqRsggtqc1+JbrP/gn
         O0bBpACubGme787uuCgKQbTv0V7zSZcmi1+d2rw/QseVTywbyZcdZFKF9mEVvWQK+zHU
         eGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ebrdQpGbryAbE+PVSjTFqlvSSqkSS1ZgUmlnEvCria0=;
        b=ppgSU4wO1dX8guJQWn+iwy4hDBZcYT/wS6+jPfIPYS4tYH7VbpZq6YDADarhqG7A1t
         TVq4en7rgsCOB1CVW79U5HEo0DYL+yZYq9u+sSLZmpIH3qkEjS1+5qvtPPHWDTpmTZzP
         0IcYT0PHUS2y6rXv8qWukYhw7cgkUO8k91LIyhtT8j3KsezkZbb1qLZRaIyJis3WGt1P
         hGsIRyW3IYqQ/bWOdK3YGiXYEeen7DgsaZ1LjK1kcHb9ER+B/GXuyuthlIYdzNSEyByr
         oqutahNMurn5Y87doB5unL7UE/k24cnbQI9h9MI5hO0G0/IEPgS3TmR+98tiIr+WlhSV
         jEqQ==
X-Gm-Message-State: APjAAAVRw09xZUHlijCELKPkUCaNzSBYcyLe6R10/Cct4qTz5Q3oZQXn
        rxgj14exEVLI8ubRAgaye6CR2BV7cMI=
X-Google-Smtp-Source: APXvYqxGmBjxCMEseACgPnI5Cfymrnnc2nKAKmnZdzJtjplWsZFE5p5T7yf6fHNJ8shzOl5yl71onA==
X-Received: by 2002:ac2:550c:: with SMTP id j12mr18293687lfk.171.1565708026123;
        Tue, 13 Aug 2019 07:53:46 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r68sm19628100lff.52.2019.08.13.07.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 07:53:45 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        dianders@chromium.org, seansw@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v4 0/3] interconnect: Add path tagging support
Date:   Tue, 13 Aug 2019 17:53:38 +0300
Message-Id: <20190813145341.28530-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SoCs that have multiple coexisting CPUs and DSPs, may have shared
interconnect buses between them. In such cases, each CPU/DSP may have
different bandwidth needs, depending on whether it is active or sleeping.
This means that we have to keep different bandwidth configurations for
the CPU (active/sleep). In such systems, usually there is a way to
communicate and synchronize this information with some firmware or pass
it to another processor responsible for monitoring and switching the
interconnect configurations based on the state of each CPU/DSP.

The above problem can be solved by introducing the path tagging concept,
that allows consumers to optionally attach a tag to each path they use.
This tag is used to differentiate between the aggregated bandwidth values
for each state. The tag is generic and how it's handled is up to the
platform specific interconnect provider drivers.

v4:
- Picked Reviewed-by tags (Thanks Evan!)
- Addressed comments on patch 3.

v3: https://lore.kernel.org/lkml/20190809121325.8138-1-georgi.djakov@linaro.org/
- New patch to add a pre_aggregate() callback.

v2: https://lore.kernel.org/lkml/20190618091724.28232-1-georgi.djakov@linaro.org/
- Store tag with the request. (Evan)
- Reorganize the code to save bandwidth values into buckets and use the
  tag as a bitfield. (Evan)
- Clear the aggregated values after icc_set().

v1: https://lore.kernel.org/lkml/20190208172152.1807-1-georgi.djakov@linaro.org/


David Dai (1):
  interconnect: qcom: Add tagging and wake/sleep support for sdm845

Georgi Djakov (2):
  interconnect: Add support for path tags
  interconnect: Add pre_aggregate() callback

 drivers/interconnect/core.c           |  27 ++++-
 drivers/interconnect/qcom/sdm845.c    | 141 ++++++++++++++++++++------
 include/linux/interconnect-provider.h |   7 +-
 include/linux/interconnect.h          |   5 +
 4 files changed, 145 insertions(+), 35 deletions(-)

