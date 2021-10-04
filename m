Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33E4207B2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 10:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJDJBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhJDJBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 05:01:43 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1419FC0613EC
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 01:59:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r201so9960638pgr.4
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xctOnjrfnqdPEoa3tip3/LlkAqa1IsoEyPkzXNFOgl4=;
        b=vD0cU/s1vm+3nN3lc+qpbOlY1NZ1fr0ctroE7oqMauOwCiUPyYuFmJq2iHdj2yHSx9
         EiHX3gnukAK5oNEdfYHdgNjabX0okaUXHKZV0xiX2RaGT2lLxg1fYfi//6zJGwUdt+SY
         6BOCQO3a9i70wemWlftieZo7eGP2Wr3PQ1ffejuZ3hT7lGtrevzshVjLoXv7AcKUJpli
         CGZSFFeFtfihedDziaakSFO46idMianbhp9G9y+bwfSdj8uOL7ppMkYEu7t8FlVnmkTn
         P36E16bLWmXY5v5vwxtlsKffKjhKBwedcJx4nIH4iyzzaXuacMz9J59SzoxdFULOmpYF
         QDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xctOnjrfnqdPEoa3tip3/LlkAqa1IsoEyPkzXNFOgl4=;
        b=hPVJUEJ4ZSQWmidmK03ZQY+l1fy9wv3+mdihbWyfAJ5hF8s1QoTeS8O5BnIB5b+2Ck
         8bp+QqIX2A5agsfLalxF6tmEqLgUeij1Qm8s+qxKkgWQ7AiIaWoRPT5r9xlqiYvOCsPH
         kDmP5/aqlndmga8K6uuvipRFzKrJHboDmnJNFmB7uuD4gp/LuJHfknbwBAkcbjB606BP
         x5wWb8NZkZLEs9F24A2Tz4XgZs1TKzGuJxQOx9CLLxUVgD6S1I1nYV+avUrELyi41XXi
         XT8IC6JBL6a1EkNvd1y26t7Xc7cc36U9/83xdTCZ3op+CDbPLdG6HGrGnEnx+a05VFOY
         pgMw==
X-Gm-Message-State: AOAM533GII3Kczwhcln5gL8aRIm1J9awtHOohToYhqe/Ncma9jfPGEpz
        Yq8IYn8Y6OdkMpFFeBlKqVYylQ==
X-Google-Smtp-Source: ABdhPJwSNvRu3CTp59vBuvr4RaMFcbMupvPQgnOOoX2hPpfzNEnqMHeDbG4cz+HBTly8u85sYIveag==
X-Received: by 2002:a63:a03:: with SMTP id 3mr9931268pgk.326.1633337994442;
        Mon, 04 Oct 2021 01:59:54 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id d24sm13622896pgv.52.2021.10.04.01.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 01:59:53 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:29:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rafael@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML
 bindings
Message-ID: <20211004085952.3k7efa3lxlll3ivy@vireshk-i7>
References: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
 <20211004070531.sexvnqmnkoe4j6a2@vireshk-i7>
 <20211004072222.GE16442@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004072222.GE16442@workstation>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-10-21, 12:52, Manivannan Sadhasivam wrote:
> On Mon, Oct 04, 2021 at 12:35:31PM +0530, Viresh Kumar wrote:
> > On 04-10-21, 10:13, Manivannan Sadhasivam wrote:
> > > Convert Qualcomm cpufreq devicetree binding to YAML.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > I am not sure if Rob ever gave this.
> > 
> 
> I'm not fooling you :)
> https://patchwork.kernel.org/project/linux-pm/patch/20210701105730.322718-5-angelogioacchino.delregno@somainline.org/#24312445

I did read that email but somehow missed the RBY :)

-- 
viresh
