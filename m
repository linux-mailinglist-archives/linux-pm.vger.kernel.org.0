Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992421AA30B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505793AbgDONDg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 09:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503617AbgDONDb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 09:03:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EBCC061A0E
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 06:03:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so11101203wmh.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQjPZcbdaiez8gPnZVEEptasSZ40rtGmLV1WRLqgzEE=;
        b=VSwRqt3Z9lmcScQ0G7eBWnQVgvgcuNvjh9qtbKIgya4dAhsx5+Q5YDTPAZUlIlsVqd
         Q51Tl3+QDwo07tHlTp7EelXW0wi0Yi7L403sJ4SMJnRwv81vD2YW5heygNkqDV6ho9Th
         JlCoEBrVJ/mpZzPq9R4PukfDdIcmxT+RrrG4iZxmz3dJB3y8GbVmQJ7BpuvEqCPOnVqT
         I5LS25e7XS9B1l3FZspq2OA2aYSsS+x4b25BEkBNZ0xNhK1KkT/QW7iOL2FveJuUpFo+
         i/+KsWFwmxTUmPxCGhyvztcdbK/LtzCoHxKSerGwGWJHTiPX7Lv4XMM/NR+Yc1AyYmXa
         y6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQjPZcbdaiez8gPnZVEEptasSZ40rtGmLV1WRLqgzEE=;
        b=VcgxtoPlOVPfPXIUhCr7fiBkMTRqM0CZ7k76rXlds7Ou60B8eMmT+WAn9KGthac3Ah
         qwA9sMYnHa3IbgvJ8mQSCo/kjGRrOjFRU5PKVwGjmgWcsz4Q/djGENMZQ3AyauPM7h1v
         u3poE9GN8A10hlS66t1vRMzH+/I/uHpIkKkBkEwpP/joeID8A0ZXaSZ9K2EbvRQVOjLS
         /7UAHibtVaP7qjEBJ+fXcV4JFzgzYIy5PaBNgc/xdHmd1MDyPIuBqPCuL7hCPdXY9RdO
         XPQ+XMpgphcJROcMR9V+za0GAwScxMzvNEnO1WjBe3mQp1YvcxTDBx4/8lvvcDEBMEL1
         979w==
X-Gm-Message-State: AGi0PuZJauTljiBL6A1I8VXLXvMLW7c08ckdVYN2kCwVG2Vxd/fH+vNJ
        28gV4fdjgy2Zm19XusDA5hiQ3I35xLU=
X-Google-Smtp-Source: APiQypLOtd28MynQpn58BxBpE7EdDidkO7rzi7NUQyfanjjWdu4P7EKBZSzTP6xF0cq5tapcaJf1Fw==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr5087120wmd.67.1586955809800;
        Wed, 15 Apr 2020 06:03:29 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id b66sm23418111wmh.12.2020.04.15.06.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 06:03:28 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 0/1] interconnect fix for 5.7
Date:   Wed, 15 Apr 2020 16:03:26 +0300
Message-Id: <20200415130327.23059-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,
This is a single fix for the current release. Please apply it to
char-misc-linus whenever possible.

Thanks,
Georgi

Mike Tipton (1):
  interconnect: qcom: Fix uninitialized tcs_cmd::wait

 drivers/interconnect/qcom/bcm-voter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

