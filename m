Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A14C3FC23E
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 07:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhHaFo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 01:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhHaFo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 01:44:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E7C061575
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 22:44:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 2so14039304pfo.8
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 22:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UqBdQdIc1fzNjTU9RHl9YOpUIZrWHS1LFDPkwLneJXs=;
        b=j5mk0SZIe3snpwuRmEln9EFwlT0U/hKOO7z9iUEpz0buMam0I/rss8GK5b9CSG0XhA
         3lfBXHErBA7Nc9rvGpp09A9QDcrk5kpQwZSdu8cUldWPnptpgjNkplNjkzmng9t1CRK+
         HdxT7FXaNgySpSuOrQC46kfVW3JAZDJcOSYXzjeN2QvZuiV3ZYzZyKLk+GF9E26plfpX
         AF+h0WqT4vBXKzU1cglphIVNkz2w9psUglDNrRd2nQMxbGE1//TGXPFEKA5XK2nSeEd7
         OuGQgQSPoSvo3iRYRQuybXLQMmU/Z1SzUUWiVjUgNp+2rPsVEW8XoeP+5Xx8jn/du+8I
         r01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UqBdQdIc1fzNjTU9RHl9YOpUIZrWHS1LFDPkwLneJXs=;
        b=ToIFH/MfChZ3b8W5S2/zo4lYUlVM/4cHEvvj6PQaDqTTQN3rn0HTubiVh0PTRruoOe
         ouCAwQfAbd+DkdKPgydB3JtoWG5EW2m3odWc9GCWtB85TkceUPDZLz7cOlrwtKbvTNZa
         Xz9DnFgJ4gl6NfRarxEKzhUd0+k+iWO1pGfP1FPJ0ZHvKZgTaKaDeKGCmmOV+ptmbtx+
         qkVd9cUj3N/E/UPN6hkfRkQzLWmlxbpaCmuZr+Ni6RJYprAApcN2tN8VEhea6ADWzjGU
         DCzVh2+tqFBvVoKN2CWmAljgmDJ9FcoSZkezVLNAbDOvpdWoPjAx++8iC49vn46nW2+a
         AjCw==
X-Gm-Message-State: AOAM531glabRsjSWuLZlrhLIZFHRRM92JtbO7CNwPtmrpZsWnmZDA4kU
        idZXE25Orvzpem3O1D3X8MnVXg==
X-Google-Smtp-Source: ABdhPJwvM6ZgWyN5pOEE2iOQ5FiWcQuYKXNb4jv3JNbJ7glftXgcjTl6COIjf/dbDZ974IvJ2JNnMw==
X-Received: by 2002:a65:4581:: with SMTP id o1mr24848959pgq.349.1630388643003;
        Mon, 30 Aug 2021 22:44:03 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id y12sm1258220pjm.42.2021.08.30.22.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 22:44:02 -0700 (PDT)
Date:   Tue, 31 Aug 2021 11:14:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.15-rc1
Message-ID: <20210831054400.voq3pxldkxezqldn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request moves the OPP bindings to DT schema (Rob Herring).

Thanks.

--
Viresh

-------------------------8<-------------------------
The following changes since commit 19526d092ceb32d619fce73fe0bdca4370890124:

  opp: core: Check for pending links before reading required_opp pointers (2021-08-23 12:44:55 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 94274f20f6bf5eb0099bbf7e133aac1f5cd087e8:

  dt-bindings: opp: Convert to DT schema (2021-08-23 12:44:55 +0530)

----------------------------------------------------------------
Rob Herring (3):
      ARM: dts: omap: Drop references to opp.txt
      dt-bindings: Clean-up OPP binding node names in examples
      dt-bindings: opp: Convert to DT schema

 .../devicetree/bindings/cpufreq/cpufreq-dt.txt     |   2 +-
 .../bindings/cpufreq/cpufreq-mediatek.txt          |   2 +-
 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |   6 +-
 .../bindings/cpufreq/nvidia,tegra20-cpufreq.txt    |   2 +-
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |   2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |   2 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |   2 +-
 .../bindings/interconnect/fsl,imx8m-noc.yaml       |   4 +-
 .../opp/allwinner,sun50i-h6-operating-points.yaml  |   4 +
 Documentation/devicetree/bindings/opp/opp-v1.yaml  |  51 ++
 .../devicetree/bindings/opp/opp-v2-base.yaml       | 214 +++++++
 Documentation/devicetree/bindings/opp/opp-v2.yaml  | 475 ++++++++++++++++
 Documentation/devicetree/bindings/opp/opp.txt      | 622 ---------------------
 Documentation/devicetree/bindings/opp/qcom-opp.txt |   2 +-
 .../bindings/opp/ti-omap5-opp-supply.txt           |   2 +-
 .../devicetree/bindings/power/power-domain.yaml    |   2 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |   1 -
 arch/arm/boot/dts/omap36xx.dtsi                    |   1 -
 18 files changed, 757 insertions(+), 639 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v1.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-base.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/opp-v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/opp.txt

