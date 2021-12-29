Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C48480F67
	for <lists+linux-pm@lfdr.de>; Wed, 29 Dec 2021 04:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbhL2Dnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Dec 2021 22:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhL2Dnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Dec 2021 22:43:49 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B0C061574
        for <linux-pm@vger.kernel.org>; Tue, 28 Dec 2021 19:43:49 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 205so17733238pfu.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Dec 2021 19:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=drRa+Nm3zkV6JRFeBOxqmRsQLs3+zng4A0DkIE8yu18=;
        b=w9gXgVSeTM9I5QY4BqhDgt4JoWG3BVxG0ALyGXnfL7sY7pvPln/gEoHoa/nrx0U+XY
         MFCtuzaU+m0HXrYt7usklQWU/Mt6mmyv46Q0OQh9y9BVqA0XMCJTIc0pT0/BPBurAfj0
         L8lyqEOu8yfxhSA3eb/O6oA7GzLWqSyrJZS65hwPyqqib9s5v25+PPkx0SUgCbPDOtHu
         cjiWTso4aWW4yT/TQAVE/FWzU8kIf1BENKJ5UH0CuJcq4Ng7tMBADJRh9/zHisKYBbGF
         SAf4YOfyRxo3PF4POMb7BR6krgK3Z+eas+GXhP0Oe+4H02lTQNnZebaVJcUbU6/MvvNh
         ozdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=drRa+Nm3zkV6JRFeBOxqmRsQLs3+zng4A0DkIE8yu18=;
        b=AB21PKoe65O/pivSSREV0njLI7n1ZDmr0bLO2Ui4wHsxz054ike6Shz4QWwUxsCsjU
         7Z3HOubJO4Qvq4bTIxEETB2NFQBOkLkc3yIuXi+M/B9BX/1egSVTWA+OCle4JFDpRu19
         pm1CseNI4YHAd0xHPe+q6L+PlLkV79a5nX5z5kXNLa4KATG938JcV5Ui2NBXoPFlawDG
         PgXhQgfZt6dxDiWpgXtWB/cN/lmPBTgw6G/xue3QRJFim4jMOmFfDXTGdIOpvwt8gcxb
         EEcSX3Ex2Seb24V1mvVwuVj2DIlk6ESXA3hc6+dE4ApOrsV14Bjnvyaw9PhuaMmw59+2
         DYqA==
X-Gm-Message-State: AOAM533GCJ8NUy9npdtkig5wNzesg0FXWXD/N1HDSjH086630ayu+nDv
        25WnM1pUAce9yR+BrOeAQEu/Kg==
X-Google-Smtp-Source: ABdhPJxr8YXyzNOrItLfpyIeldl0R6q1VssNNrizWbzHGV7DIn3RobeA3Uhsr8wCs8cM3RG8d9gmKg==
X-Received: by 2002:a63:5147:: with SMTP id r7mr21356630pgl.581.1640749428578;
        Tue, 28 Dec 2021 19:43:48 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id e24sm23567315pjt.45.2021.12.28.19.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 19:43:48 -0800 (PST)
Date:   Wed, 29 Dec 2021 09:13:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.17-rc1
Message-ID: <20211229034341.juivahmqhoqzjtgo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request updates the documentation to match with the latest code.

Thanks.

--
Viresh

-------------------------8<-------------------------
The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 489a00ef46c93e85ed540d91836317cc469371ac:

  Documentation: power: Update outdated contents in opp.rst (2021-12-27 09:47:52 +0530)

----------------------------------------------------------------
Tang Yizhou (1):
      Documentation: power: Update outdated contents in opp.rst

 Documentation/power/opp.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
viresh
