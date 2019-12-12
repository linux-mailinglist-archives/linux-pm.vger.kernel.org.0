Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBD11C6B2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 08:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfLLHxf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 02:53:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42506 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfLLHxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 02:53:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so1571039wro.9
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 23:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IJXVdneHJKhB0U91ipQr9JiHsEf8lKmyUeV2ozlf9kU=;
        b=paKL9cFHlHryFquBJHL+8c4NN4kE9PP2TvzfRSav5Y/5+yw5gKqPq/F+WsFuviGnpX
         a3N5Dc+grTp5ujUOVDDT3useFQsOf8f3H6+AWoVl/PsE849P9TMbT30Lf3eqe8ZLoIXG
         I6q7zGxsRYwkzhule7RMZqm2qK+rkFCXm/kO+S33hmiNR/k+T4PI95a/HKD7SSwyos9E
         bWn3z65M5wixIxoJYNYD2CjR9u6NAiPYdcbziByEhEf1OGDwc7aA0cu3gPrBezd4iuRX
         cYB03DDXS5G40yust2I6oE2A4yU3xKDuJy34dLP4G85A+uhDKJC04s+4Qplwdl0A5rLb
         uOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IJXVdneHJKhB0U91ipQr9JiHsEf8lKmyUeV2ozlf9kU=;
        b=AiSggLurswno8xPVb5w4npnkhnv/SjxLqpPtZ9Yzz1XzJOyGbC2zif4ISKIwy82VKA
         dSuIDq2wfzJEmyui65SL8cLO2/YLK9XgyaN7LKBo/4AZqTMnlw36ddZEnklaxB1w+O1t
         M9UB7n6MtKV+6dQQyb2WQKL799+1OAESXLxEawphe4m45RjQCr3mZQSdu3+lXelitH29
         EBJLjgR0wc41sZFVwn5L6N9GzfNZpyRhrfj8hwaI/OSUBaIY7u+FdOOZOcGiVPIbx9G1
         5LcMGZlOKeBF0qlSx5djqVp+S4hmsyxPx7vhr0dUAkC3zFu8JkKX0qM9nUxVn5dLzKAQ
         rKjg==
X-Gm-Message-State: APjAAAUAh1fbmq4pnM6iYh6+ubYV9SfEQNbvwxeH6ThzvUmEC8GvUcxv
        BaDyb/oAnfumwB5N+jJkQHwLug==
X-Google-Smtp-Source: APXvYqzM+pvEcMGMPeMb7kguiSsOu7enKlFBuvbc6gZwJOO5/qoaoDt+tHt0EEFhY411UtUb0P6eYA==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr4594651wrq.57.1576137213471;
        Wed, 11 Dec 2019 23:53:33 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x6sm5636742wmi.44.2019.12.11.23.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 23:53:32 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 0/4] interconnect fixes for 5.5
Date:   Thu, 12 Dec 2019 09:53:28 +0200
Message-Id: <20191212075332.16202-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

Here are some fixes for 5.5-rc. This includes fixing a linked list
corruption in some drivers and a Kconfig indentation fix. Two of
the patches are tagged for stable. Please apply to char-misc when
possible.

Thanks,
Georgi

Georgi Djakov (3):
  interconnect: qcom: sdm845: Walk the list safely on node removal
  interconnect: qcom: qcs404: Walk the list safely on node removal
  interconnect: qcom: msm8974: Walk the list safely on node removal

Krzysztof Kozlowski (1):
  interconnect: qcom: Fix Kconfig indentation

 drivers/interconnect/qcom/Kconfig   | 14 +++++++-------
 drivers/interconnect/qcom/msm8974.c |  8 ++++----
 drivers/interconnect/qcom/qcs404.c  |  8 ++++----
 drivers/interconnect/qcom/sdm845.c  |  4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

