Return-Path: <linux-pm+bounces-42061-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMziNTowg2kwjAMAu9opvQ
	(envelope-from <linux-pm+bounces-42061-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:40:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 402D3E53B9
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86CC330078C3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C453DA7C7;
	Wed,  4 Feb 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEtZJ0di"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9023D7D88
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205239; cv=pass; b=lPms0s41fpgTtbrrS1gZe0jnsD3BLgLqmdr7okHlxXsI8lcOBi04v24TagQ+FpmkiY5fez2EZ+peCXaMuGypc01hHoGDPT9oOeIN8ffl4822nth7teIxN0P2vaKLfiYr+Heh8Lb8Fdf/FWOF34AIJiJPveY63/aw1XCq8sUuTbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205239; c=relaxed/simple;
	bh=BLLQuyw5B/L37gprXVSCeQEGNy84sZq5SF6Ql4eeHUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uc1F7QfDr0y3NkPz8Y2f+AS1NsWPnkK9ovX+RlhtRqAlDcg86hwOa2r4itM6KVQRclYWthHCIumsHS/HDhNcOQCbAk5EHA9Cp/SSwAuJDg33JRrmYtJhBCY0rtTUBAZsL/9ce8VoqHR3HNBJACaQKOwC5RgCPYvLoG99qvFJsWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEtZJ0di; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b9fee282dso6444485e87.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 03:40:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770205237; cv=none;
        d=google.com; s=arc-20240605;
        b=lm6GHBUAqOczaOhylHdF2HJIMthm5fAXdPdyAxnZ1KwcVuLtZFmq4m9DBggRSla+Ag
         kIrLqs0QzCrHVZkz/9AatesOmy3I2+xPXABDHng9/0K1Mn7/Hai0NkuvggxdPQS/F6qH
         Exxeex65+316WnWRAwQEAQ7tvjsdDaF1O5JAW/fyT5T1mFfJCbjbDhIQUE5pgXT+LKHD
         6FM3qrTMNnYZzkLwBFAjCyJMhaF7O0hlRlzCSe+AhJPPn2I4lPDQc/T+R/UU2uISF6rE
         EJ0bMr2LFjlHLZEOBicXRib2rkTHksPagxp8am7Qi9BYlhELb3t0pYK6NRqhlU0FB+2I
         0M7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pzk9ekf+w5m7EprZs0DpKyLz/hJhYQ3DquAy3S2RPkE=;
        fh=epESfbj427a3OUv0yrvhjor0UXD2EwoN7mwvapCdo7I=;
        b=Jopl0BemvVDDhNecqm1kqKBuVlVhc1MB76bw5Uy8m4gmA5Y72wAJ17QFdzmuw4MXRe
         rgoH68AzU4G+tOznZuUXiJdTxojVlTk7njhG57Ep+PPx1cwyhjLwghW5l4abXKn5GsLK
         rNDnL7GuVjXGrt+22/f5wD/5M6/tROQlpZeziqoIN+CfINH5Whr2OPM9O4FzMFz0cmqB
         awGxqGs3vYy2UOvTsN1+ZEDJwa7VvGIlS7HWPd1qK6wv4vYgcYCpBnn4W6jG8Ewlr7j/
         u37PKLqYth0znXdABVsltMyyhWw720GWzHgakcoMy3s87Rc5Zso4Wq0iIX8pdkT7sQEF
         FoyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770205237; x=1770810037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzk9ekf+w5m7EprZs0DpKyLz/hJhYQ3DquAy3S2RPkE=;
        b=IEtZJ0dibOQG0DB24tVOWnKDF0lCWavGF6ell2KZRq8YSLfrPGZnBoZyYJole2GMN3
         MjI3IIoJsr5EbSJeBHZ31QO53fVdKEc1NT6bz8zZ6HoALlWYMAx4ky0PZIuyb2lc8yuS
         IghJmFuVxx92xVYNEyatgqYG+UY4JhE1obA28YCb00CZCuGrUAZt/HHv/BkLOsn7WuiF
         9WAFs+41Nt14fQUxpo1RrBAwYWujibPw/fB0FQfh33vWbfKN066zp+fdYa9AI0RopQ0t
         HW2i15o8DjDFRgOn7F3TiMGYw+G2hHOK0PWoDyzreOUKg5ihrKewgzc/4mQfYT1nnBsO
         qMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770205237; x=1770810037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzk9ekf+w5m7EprZs0DpKyLz/hJhYQ3DquAy3S2RPkE=;
        b=QaPRgKE+9YhBdqPqJYZDGScQm4JK5KNcYvqKnooflV/KExYeSAj89J6AVwWKPSKKfz
         okmKZzT/5zRfJzE3PKqhJu/7ti5aUUqT5ucxACsO1xQexjRGzOnqHaZnXBUk9uPXCcGV
         x5XBzB+3FJtsDU4vcvsyLfg5g6LQA/svRshX230YzgDJnPgAIfVZBnzRQcJ118zD0jQi
         VG79yN3hOKAHskFgMbuOoveOQx+WsdXGsgUrFXVGi1pGqH4yGuLpgtbYbI1/UWd5A8R9
         lTAodCEiBn+uymr3NmEahxw6bmkUuerVy+D4p5jyxx3oR54hOuo+tg1FDO9CrX2A0OnK
         bzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAluvEtMBC/VDIhITBpBLxtvW3zoXtYkWH5gN4MjEWPcf2w51QUipRf5wPu5/0/tMEicBuHlypdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYa3LlXGKkbpW4eaHr9RZfJXh2ILdllfq6cGxd2Ss6pxYQjjv/
	8rB5q6ACASV0wYoGifZgGGE+/9uJir7pDg8x+B9x5Ky0ZNCReUl6+FHuzLSaGzfCm94IwDF1lkm
	/ibOCA/ggMLN7Sg4QQ7nwebmgZoOa0rKR7TjLBsZxtQ==
X-Gm-Gg: AZuq6aKyL4LcAsSxi3Wud8lsSVxtDWvFKg4dFWdvBQiwHGNYktKABGqKgtoErEhIL3i
	pxN39yLmMs7lGG7K/z/YEtBpmfctWKzoYDsDiv0j7B5IUYNSVL9cFuaHaT7m/0q0sO119tjquVR
	8JLkh0DuEhbJk2XZHVAosTCpOB+TDT0ZbE+tls0nx9/PghzzuZg8yFDacd3rEfiYTYFSGrDYbaY
	3bnDyhiHyAxi9OmhuH4YphLNzLLFT62N25Rs1Z1WkePR8Qh4K2ggQzIbLNbBKHSZ2a82VoBVfgX
	zNpJhtQ=
X-Received: by 2002:a05:6512:1085:b0:59e:14f:a4d7 with SMTP id
 2adb3069b0e04-59e38c2d748mr1017297e87.27.1770205237316; Wed, 04 Feb 2026
 03:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202074730.738760-1-xu.yang_2@nxp.com> <CAPDyKFpqfo1R8Qkq284L9DTURjZnvm_n8W3a6KQTomg7A-M_Ug@mail.gmail.com>
 <lh3cb2r3qvv2ar76ai33fjiuseqyiwoks2zjrmowknvut4qfcg@2db76miyk4wn>
In-Reply-To: <lh3cb2r3qvv2ar76ai33fjiuseqyiwoks2zjrmowknvut4qfcg@2db76miyk4wn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 12:40:01 +0100
X-Gm-Features: AZwV_QiX5AkXx_w9Zse93HKg4-tfhffXTYB6o8jqYrd0yS7lV2JQJGMo75ani6o
Message-ID: <CAPDyKFpFfhMTtAp63cjB2eVR78mbhBEzzSBr1Zxk-14YT448Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: imx8mp-blk-ctrl: set awake path for
 power_dev if attached device needs wakeup
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, peng.fan@nxp.com, jun.li@nxp.com, 
	rafael.j.wysocki@intel.com, a.fatoum@pengutronix.de, ping.bai@nxp.com, 
	shawnguo@kernel.org, l.stach@pengutronix.de, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42061-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,intel.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim,mail.gmail.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 402D3E53B9
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 at 09:48, Xu Yang <xu.yang_2@nxp.com> wrote:
>
> On Tue, Feb 03, 2026 at 12:06:28PM +0100, Ulf Hansson wrote:
> > On Mon, 2 Feb 2026 at 08:46, Xu Yang <xu.yang_2@nxp.com> wrote:
> > > +
> > > +               list_for_each_entry(pdd, &domain->genpd.dev_list, list_node) {
> > > +                       if (device_awake_path(pdd->dev)) {
> > > +                               device_set_awake_path(domain->power_dev);
> > > +                               break;
> > > +                       }
> > > +               }
> >
> > This is really messy in my opinion. Ideally the above should not be
> > used by a genpd provider as it's internal data structures are managed
> > by genpd itself.
> >
> > If I understand correctly, this problem boils down to the fact that we
> > should have tried harder to model child/parent domains, rather than
> > using runtime PM to manage the parent domains. I understand there are
> > problems with that, due to specific power on/off sequences we have for
> > imx power-domains, but I wonder if those could be managed better by
> > using genpd on/off notifiers?
>
> Indeed. I have tried using subdomain will resolve the wakeup issue because
> the parent domain will manage the child domain. But I shouldn't use
> subdomain and runtime PM way together to avoid any unexpected behaviors
> according to my understanding.

Well, there is nothing wrong with using child/parent domain in
combination with runtime PM.

Although in general using runtime PM to manage parents domains from
child domains, should be better managed by genpd itself.

>
> >
> > Anyway, that said. Rather than walking through the list of devices as
> > above, I suggest that you use the ->power_off() callback for the
> > corresponding genpd(s) to dev in combination with a genpd power on/off
> > notifier for the corresponding genpd that the power_dev is attached
> > to.
> >
> > More precisely, if the "child domain(s)" that corresponds to "dev" has
> > not been powered-off (because device_awake_path() is set for some
> > device) during system suspend, the power-off notifier should return
> > NOTIFY_BAD to prevent the "parent domain" that corresponds to
> > power_dev from being powered-off.
> >
> > Would that work, you think?
>
> Thank you for the suggestion. It works for me.

Great!

>
> With this way the rejected count is increasing. Does this have any impact?
> The count is just used for statistics, right?

Yes, it's used for statistics.

>
> # cat /sys/kernel/debug/pm_genpd/usb-otg2/idle_states
> State          Time Spent(ms) Usage      Rejected   Above      Below
> S0             1203           0          1          0          0
>
> Thanks,
> Xu Yang

Kind regards
Uffe

