Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F5A12F1C1
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 00:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgABXTq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 18:19:46 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:52078 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgABXTq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 18:19:46 -0500
Received: by mail-qv1-f74.google.com with SMTP id x22so27111962qvc.18
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 15:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2rkxtj75qMmfFejsblg4LJbRA0O8Af2ULdce3nvFog0=;
        b=uhQiZSmKc1Zb11oPLNBuwsrSubMw8/+Y9CncU93zXzCLH5ifXZcQCiHKDmPEFUv3ut
         aB62L1LiZqkh4XfxljqKAUGR7ztSjhaK35zg4OIOn2DiIFKMkXJhlZAUyfM6lLCcT6lq
         1Le2d488KwFvDyVeupm55mU1VKtCHL6zZD6VeuVJtzgWOKC0e9Hp2A+DZMhzuzoD/X/5
         zplDjv9kBkqYgFS7Aat2AqzkFQx+i/UD+oV1jP2NkLGfJnlNLHnfhlh4TiHSOd3IdGGL
         2GSauE6rKMKxsuGL1tddqDROOPnwgAZKglkFdhuCq7JNiElGB3DcuiwkcJnGB513Ou1D
         j3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2rkxtj75qMmfFejsblg4LJbRA0O8Af2ULdce3nvFog0=;
        b=DoZvaQ2E8HHuYmpWDz6iSt38gSJbpm8uLUethmUcWYFd8E42DG1sN4eahCcMwDdnnZ
         vNvy6P0xrerxEtdOoZtleAatWCYTE0mRdW6ZQ0I8AC+UYxKRB/h2MozPDiX+X1aKHhSj
         3vda9jhmiwZyg0LteSNZWmO9uGxWrvMYwCI5TeIUXpj/jD2Ps6IyIGpXmHs+TF2bIMts
         2eWogL/E4/Vreke4buUMadjuJzU4LQGMoVjfBxNO/eGvSx9O53BC9SVzpcUzFTVSJlV0
         BbCTB2MiWMeOxyL1TWSFXHsJVxs4BJfRlAjeu5trnBfaEaDj1Sr8zY2C3EGfcbziHPlP
         /lBg==
X-Gm-Message-State: APjAAAV1m/inmxqFgF1IQ0mm5rZ9EMf2211RbrbRB+gDP7UJIu81Dch1
        Af2N1GxP7SEPR4lo9kBsXjevVlJHKsJ2BeCdjG1uTBiWizSWv33eN0Loz+zNt9PBfgkmkYfA2ol
        ex2tSx77vidae3AQBlHLYp2r+bzCmPGkbg7aU4P8iOs+vF/SvSKPj8nUSkAkYv7HCMHIUaf6t
X-Google-Smtp-Source: APXvYqx8c7zVcXDY/Cwj64hjKpKRzguhHQv4ZIEGXQzRIUaYrwfKYydw5gsrFLdwtIbWB3v8ihWrFV0GdnMBDbQ=
X-Received: by 2002:ac8:383d:: with SMTP id q58mr60717171qtb.45.1578007184895;
 Thu, 02 Jan 2020 15:19:44 -0800 (PST)
Date:   Thu,  2 Jan 2020 15:19:38 -0800
Message-Id: <20200102231940.202896-1-semenzato@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 0/2] clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        elliott@hpe.com, Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These patches aim to make it clearer under which circumstances
hibernation will function as expected.  They include one documentation
change, and one change which logs more information on failure to
enter hibernation.

---- comments on patch versions ----

As suggested, v3 makes the log messages more consistent, by including the term
"hibernation" in most of them (if not all).  (I think this was worth it, also
because this code doesn't change often, but we're quickly entering the region
of diminishing returns.)

v2 uses better terminology in the Documentation, and removes a suggestion
for a workaround.

-----------------------------------

Luigi Semenzato (2):
  Documentation: clarify limitations of hibernation
  pm: add more logging on hibernation failure

 Documentation/admin-guide/pm/sleep-states.rst | 12 +++++++++-
 kernel/power/hibernate.c                      | 23 +++++++++---------
 kernel/power/snapshot.c                       | 24 ++++++++++++-------
 3 files changed, 38 insertions(+), 21 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

