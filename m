Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BA71B3BC7
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDVJyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgDVJyg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 05:54:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC231C03C1A8
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 02:54:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so793254pfb.10
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZnRYQIuz/oWsnKCxALP77zFF3I4egwyDXu/gk4mzZEc=;
        b=HI7GbyfATDGT+Y2utDx7D03/q81Sritm7ktBrSib23wE+ApbuXzUvLF8833mGxeugq
         h3QP2qcpIuieHxEJPBBxecLIHRpnsOy3MejkfJltAnBDx5dUFRDgpvSBl5UUgxXs4VjM
         YC2Z3kfwmRPOD8QHsCe2NWPqNU5knQ+NYRHRFHLfEF85R8NWQN2G3aOOkLLi2WuLZK5E
         /mGDvQiVlynWrf1F08EgdTQkqBy7SfGPJdDMlWDDiSnVoqUjJV88NnQyXBYtQ74NM5a3
         r7JCNyP3l1AlmkXboxF9jVgImNnFY9RDuwJgyyCDNtyaVxn+yMQVgO0ba9ritdK6v4cA
         7jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZnRYQIuz/oWsnKCxALP77zFF3I4egwyDXu/gk4mzZEc=;
        b=iLxWZovt3+WYShmYAFu+ohew6BtODu4NQB2OByaqZ4uFIEIhT/p5y+Ll5a3+yEuedu
         ilYZ9ADjOzV4q9LgTlqwAtGlZOj0Wps576k3oMWsZ493EvbzicU8/vQcYmFQlRcmHbcF
         DUOzOjDsYD1Jwqj8XGN/9ydCZQH5kzsT4c5Sa0+99wFrtXEPeDBT+eMIkc+397F/r0+f
         IJJMlBh9qwikNm8d1Oa0RiRF0exUtxJ9y7vJpD3ajAUuS/YfaNt+n37ukZQKrwmnPL5x
         v+QknjjtpSuguiktxz3EFDDFGRI7gkve0zLkeKn5IY1y7dUYziktAMv7av5FpQpmFWou
         CESw==
X-Gm-Message-State: AGi0PuYmPiO2osrEL+Xe0UTpiO4w1HF1pFwZfZu8gsYK4zV9wZuD1MFh
        pohB6C+/kdidQrR+bnDcBST+uQ==
X-Google-Smtp-Source: APiQypIEdmpUviHCLUU+4j7++aK32z0B4iLLu5GheWkFazIEsUmr7WHQGXOEXB/k9cVthBE/DsN7hw==
X-Received: by 2002:a63:fc45:: with SMTP id r5mr24014205pgk.440.1587549276185;
        Wed, 22 Apr 2020 02:54:36 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id 138sm3191382pfz.31.2020.04.22.02.54.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 02:54:35 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:24:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     gao yunxiao <gao.yunxiao6@gmail.com>
Cc:     daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
Subject: Re: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform
 callback functions
Message-ID: <20200422095433.br2zgpzm7f66ydhi@vireshk-i7>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
 <20200422080439.kkpl7xmaawkxu5re@vireshk-i7>
 <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANO_MSLwA6PWEqGEbj50y98TR=trqddENQ6Qcne5edvf1oi9jg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-04-20, 17:53, gao yunxiao wrote:
> viresh
> 
> Thank you very much for your advice.
> 
> In here, only check whether the frequency point given by cpu_cooling
> module is the minimum frequency point.

I am not sure I understood what you are doing here. Please elaborate a
bit.

-- 
viresh
