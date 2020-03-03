Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B21176EEB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 06:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgCCFpx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 00:45:53 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35641 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCCFpx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 00:45:53 -0500
Received: by mail-pg1-f172.google.com with SMTP id 7so999992pgr.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2020 21:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wnuce1BEMaLV9odhtqcw36E1SWjthugxOUocptLg1eU=;
        b=tc6nFv9M1NJtZB1NZhMnMMn6js7Ufn+yAAM+nS75545HYTHHzMPWGwB+kN2uLa1y2j
         OS3lxooIOHPQRvcMKNTWdlCJzpZJOVZJfVXXJQ5jf4D99Jb5BxdUL2ZTnsUa2Ozqhm5B
         ypujDRL2Xo4QOYZdT8VqjznTd4gVeuj3f25IxpLMeKJKzy86YKYyHW4I4CLfTvbHS2L+
         EeCvqRAyLVj+GCeE3Zz6GRqojyzCP8llrgoppm0080Mb6QV7/xU2PjO0APxo9Z9ZzN0c
         BCXflIKd2wGxlOuTH+TRsmWSR3Gi5kZaCo44SDUX2B1awqkBIxoFxhN+LAd+nd42zwQO
         595A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wnuce1BEMaLV9odhtqcw36E1SWjthugxOUocptLg1eU=;
        b=ign7FKaiTiEfymZeifKPdPbtq2nSzhWKF2tSUfzgvvm88Hv8j8lvKNUew24eq2kF9f
         zK0wh2eyvMuq59BfKQvwGg8Ev17PKswIK5EEG2CXT2HleAnJRw7akapdoVOObvowzMhy
         Gt0Ct2/g0GsT5C3S0m7AjNnRKPb4+U4/6WlEKozlKXjQuO3HnzQLpPT8y6tZEw+738nF
         WQ5iYZbyCcYUMyID9kn3rv3ZeEbupm+f5TYB54ddfxH785FcsMX2O5X05rppYlBai53Q
         9vDpud3NQVYbHxgKQ9Q3pKeqxwYQnGeYDNnscuV8BqRhm/Z6IbqNm5Yyk3a8POr5eIGP
         /3+w==
X-Gm-Message-State: ANhLgQ24Y6ySeys/awzMEh3XT7YXxxVh7Lc60Dk2hu2PHsglMO9HsCkc
        geXYYNnjVYwz6k/KchwY+biRGg==
X-Google-Smtp-Source: ADFU+vtlUTCjeL46Zb2JwQRGCfBgPlvipN94mw2Bm1lTmvsdnScdE/DSOFjY1YTYg9ynNjhLyHpAfw==
X-Received: by 2002:a63:cd16:: with SMTP id i22mr2517574pgg.79.1583214350354;
        Mon, 02 Mar 2020 21:45:50 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id m16sm22664861pfh.60.2020.03.02.21.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 21:45:49 -0800 (PST)
Date:   Tue, 3 Mar 2020 11:15:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
Message-ID: <20200303054547.4wpnzmgnuo7jd2qa@vireshk-i7>
References: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-03-20, 10:14, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use nvmem API is better compared with direclty accessing OCOTP registers.
> nvmem could handle OCOTP clk, defer probe.
> 
> Patch 1/3 is dts changes to add nvmem related properties
> Patch 2/3 is a bug fix
> Patch 3/3 is convert to nvmem API

Should I apply patch 2 and 3 ? And you can take 1/3 via ARM Soc tree
as this shouldn't break anything.

-- 
viresh
