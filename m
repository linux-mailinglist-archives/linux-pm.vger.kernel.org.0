Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2272FEC362
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfKANAh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:00:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41984 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfKANAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 09:00:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so9586416wrf.9
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnAtrIp1CQEJrAviLU5bc1LnukML3+XTcip2l+4dcgE=;
        b=EC15ozzq5r6O7Xmzqx3qzWh0ljIqUYns6h1WdyJ7AKAd20rZqTYo9V9KHWyQiCtzJc
         647HxCf7/prcMBcdFlUb80gkD8T5S30CtKLZvt5UJ4OJGH8gNIxehms7v8Fs+Y7IBDIF
         YtWlCjv71EcQ+rsc5bShlkFA17hS8F5ax7Xv9WftYOAtj1Y7JC64GTo7j+4hyTapTeR2
         GLiE/RjbbB+jkC+dEm2veHwxFVO5lieAqz+rHWsx5p61xB2Pf5xq0SGSDK2BZSb7RPRJ
         YQevWkOvlEwSkJSLoJkq2wkc7gSZiOr6JkUy7L3agZGpFF2ZgMcCD/fj+PlyWwbxm0r0
         NliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnAtrIp1CQEJrAviLU5bc1LnukML3+XTcip2l+4dcgE=;
        b=UXstmU3LYpFpXx+JbJVPWf5ElsX+l7xRer9J3o/W6EbITipWf8wnOfT+ub2eckJbFg
         K1Cr8s9cXV77NegVFNQzi9LHAxNDW3B5RQzIOh8f67YcYktKuLCbS/DjCeRvJVsTeQRZ
         YyuYbX3q3ydWeCdNfOAss0L6XYdVpEcM/Qmb6Twbsu+Cc2kfEYXnXLQftEWLRk6Qt4KC
         3vFrYodiPG+pYECps27UZPfKoHnB0T5dzdv6Ig7rM4b8+IoajcJ7OPlRWiaVYc4MxUR8
         Ao0oeBLUWQAAFwg/3m8QwQyCVQVmwmkACoikL8FQaOzgUo7nwgsmq+sy7caAqU9lNNTS
         SvaA==
X-Gm-Message-State: APjAAAVbtHiIobU1q0iSkJnwx65XLtAlJMpd+sZQ9p4iYhKZqxFNxCcz
        xTqBCXKQ484QJZOlSUgulxyDOhT9fG4=
X-Google-Smtp-Source: APXvYqwBJap78uhfylY8s1lRyzHMgoLG9vqE82nyBm2uLab+9M9LZMN2Ea5nZ9jbJRyQeJNGuqcRdQ==
X-Received: by 2002:adf:db42:: with SMTP id f2mr3231266wrj.287.1572613233401;
        Fri, 01 Nov 2019 06:00:33 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x7sm14208476wrg.63.2019.11.01.06.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Nov 2019 06:00:32 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 0/3] interconnect: Add basic tracepoints
Date:   Fri,  1 Nov 2019 15:00:28 +0200
Message-Id: <20191101130031.27996-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tracepoints can help with understanding the system behavior of a
given interconnect path when the consumer drivers change their bandwidth
demands. This might be interesting when we want to monitor the requested
interconnect bandwidth for each client driver. The paths may share the
same nodes and this will help to understand "who and when is requesting
what". All this is useful for subsystem drivers developers and may also
provide hints when optimizing the power and performance profile of the
system.

v2:
- Moved dev_name() into TP_fast_assign() to reduce cache footprint. (Steven)
- Added path name to traces (Bjorn)
- Added trace for path, device and ret. (Bjorn)

v1: https://lore.kernel.org/r/20191018140224.15087-1-georgi.djakov@linaro.org

Georgi Djakov (3):
  interconnect: Move internal structs into a separate file
  interconnect: Add a name to struct icc_path
  interconnect: Add basic tracepoints

 MAINTAINERS                         |  1 +
 drivers/interconnect/core.c         | 53 ++++++++-----------
 drivers/interconnect/internal.h     | 42 +++++++++++++++
 include/trace/events/interconnect.h | 81 +++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 30 deletions(-)
 create mode 100644 drivers/interconnect/internal.h
 create mode 100644 include/trace/events/interconnect.h

